/** Level class */

public class Level3 {
  PImage background, gameOver, youWin, youLose, selectContinue, selectMenu, neonBox, level3Sign, scoreSign, livesSign, heart;                        

  // Spaceship 
  Spaceship spaceship;                                                                                     //spaceship object
  float spaceshipLeft=250, spaceshipTop=700, spaceshipWidth=100, spaceshipHeight=70, spaceshipCentre=50;   //dimensions of spaceship

  // Alien
  Alien alien;                                              //alien object
  float[][] alienPositions;                                 //2D array of aliens' positions
  float alienLeft, alienRight, alienBottom;                 //dimensions ofint currentAlien; //index of alien to be removed 


  //Bullet
  Bullet bullet, currentBullet;                             //bullet objects
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();      //array list of bullets
  float bulletW = 10, bulletH = 20, bulletSpeed = 10;       //dimensions of bullet
  boolean shooting = false;                                 //user has not shot bullet

  // Heart
  float heartL = 460, heartT = 0, heartW = 40, heartH = 33;

  //Score
  Score sObject;

  float speed = 9.0;                                         //speed of the spaceship
  float vx = speed;                                          //horizontal speed of the spaceship
  int count, level, numOfLives, lose = 0, initialiser = 0, currentScore;                    //num of counts since starting the program, current level, num of lives           
  boolean hasWon = false, userLost = false;                  //user has not won the game


  // Select continue and menu button
  float cLeft = 185, cTop = 480, cWidth = 240, cHeight = 65;                             //dimensions of continue box
  float mLeft = cLeft+45, mTop = cTop + 100, mWidth = 150, mHeight = 65;                      //dimensions of menu box
  float neonLeft = 102, neonTop = cTop-45, neonWidth = 430, neonHeight = 160;            //dimensions of neon box


  // Constructor
  Level3(int num, String bg, String yWin, String yLose, String gOver, String c, String m, String nb, String l3, String s, String l, String h, Alien a, float[][] alienPos, Score scoreObject) {
    //Level3(int num, String bg, String yWin, String gOver, String c, String m, String nb, String l3, String s, String l, Alien a) {
    level = num;
    background = loadImage(bg);
    youWin = loadImage(yWin);
    youLose = loadImage(yLose);
    gameOver = loadImage(gOver);
    selectContinue = loadImage(c);
    selectMenu = loadImage(m);
    neonBox = loadImage(nb);
    level3Sign = loadImage(l3);
    scoreSign = loadImage(s);
    livesSign = loadImage(l);
    heart = loadImage(h);
    alien = a;
    alienPositions = alienPos;
    sObject = scoreObject;
  }

  /** Draws Level 3 Interface */
  //void redraw(int counter, int lives, float[][] alienPos) {
  void redraw(int counter, int lives) {
    background(0);
    image(background, 0, 0, 600, 800);   //draws background
    displayText();
    displayHearts();
    count = counter; 

    //sets initial score once
    if (initialiser == 0) {
      currentScore = sObject.getCurrentScore();
      println("L3 start score: " + currentScore);
    }

    //sets original life once
    if (lose == 0)
      numOfLives = lives;

    //println("L3 num of lives: " + numOfLives);

    sObject.drawScore();

    keyPressed();                       // initiates key listener

    //constructs spaceship 
    spaceship = new Spaceship("spaceship1.png", spaceshipLeft, spaceshipTop, spaceshipWidth, spaceshipHeight);

    //displays spaceship and aliens
    spaceship.display(); 
    //if (level == 1)
    alien.displayAliens2(alienPositions);

    moveAliens();                       //moves aliens
    showBullet();                       //displays bullet

    //if bullet is hitting an alien, remove alien and bullet
    if (isHittingAlien()) {
      sObject.addScore(10);                      //adds score
      currentScore += 10;
      currentScore = sObject.getCurrentScore();  //updates score
      println("L3 new score: " + currentScore);
      doCollisions(currentBullet, currentAlien);
    }

    //if user has won, end game
    if (hasWon()) {
      displayYouWin();
      displaySelectMenu();

      //goes back to main menu if player selects "menu"
      if (mouseOnMenu()) 
        displayNeonBoxMenu();
    }
    //if aliens reach the end of the screen, player loses
    if (userLost) {
      //decreases life by 1
      if (lose == 1)
        numOfLives = decreaseLife();

      lose++ ;              //num of times userLost is called

      //if (numOfLives == 0)
        displayGameOver();
      //else 
      //displayYouLose();

      displaySelectMenu();
      if (mouseOnMenu()) 
        displayNeonBoxMenu();
    }

    initialiser++;
  }

  /** Moves the spaceship and shoots using the mouse keys*/
  void keyPressed() {
    // move spaceship left
    if (keyCode==LEFT && spaceshipLeft >= 0) {
      this.spaceshipLeft -= vx; 
      keyCode = UP;                     //change key code (stops movement)
    }

    // move spaceship right
    else if (keyCode==RIGHT && spaceshipWidth+spaceshipLeft<=width) {
      this.spaceshipLeft += vx; 
      keyCode = UP;
    }

    // if user shoots
    else if (keyCode==' ') {
      if (bullets!=null && bullets.size()<=2) {
        bullets.add(new Bullet(spaceshipLeft+spaceshipCentre-5, spaceshipTop-bulletH, bulletW, bulletH, bulletSpeed));
        keyCode = UP;
      }
      shooting = true;
    }
  }

  /** If user has fired bullet, display and move bullet */
  void showBullet() {
    if (shooting) 
      for (int i=0; i<bullets.size(); i++) {
        bullets.get(i).displayBullet();
        bullets.get(i).moveBullet();

        //removes bullet if goes off the top of the screen
        if (bullets.get(i).getY() <= -5) 
          bullets.remove(bullets.get(i));
      }
  }


  /** Moves aliens on screen */
  void moveAliens() {
    //println("move aliens");
    if (count>=0 && count<=30) 
      alien.moveRight(alienPositions);  //move right
    else if (count>=31 && count<=41)  
      alien.moveDown(alienPositions);  //move down
    else if (count >=42 && count <=72)
      alien.moveLeft(alienPositions);  //move left
    else if (count<=82)
      alien.moveDown(alienPositions);  //move down
  }

  /** method returns true if bullet is hitting an alien */
  boolean isHittingAlien() {

    for (int i=0; i<alienPositions.length; i++) {
      //gets the left, right and bottom of current alien in array
      float alienL = alien.getLeftSide(alienPositions, i);
      float alienR = alien.getRightSide(alienPositions, i);
      float alienB = alien.getBottom(alienPositions, i);
      //rect(alienR, alienB, 5,5);
      //checks if bullet is hitting current alien
      for (int j=0; j<bullets.size(); j++) {
        //gets the x and y position of bullet and RHS
        float bLeft = bullets.get(j).getX(); 
        float bTop = bullets.get(j).getY(); 
        float bRight = bullets.get(j).getRight(); 

        //returns true if bullet is hitting bottom of alien
        if ((bTop <= alienB) && (bRight >= alienL && bLeft <= alienR)) {
          currentBullet = bullets.get(j); //bullet that needs to be removed
          currentAlien = i;  //index of alien that needs to be removed
          return true;
        }
      }
    }
    return false;
  }

  /* removes bullet and alien from respective lists */
  void doCollisions(Bullet b, int index) {
    bullets.remove(b);
    alienPositions[index] = null;
  }

  /** checks if user has won the game */
  boolean hasWon() {  

    //conditions for losing:
    //if array list is not empty, user has not yet won
    //if aliens touch the bottom of the screen, user loses
    //if spaceship is touching an alien
    //if number of lives reaches zero
    if (numOfLives == 0) {
      userLost = true;
      return false;
    }

    for (int i=0; i<alienPositions.length; i++) {
      if (alienPositions[i]!=null) {
        if (alien.isTouchingGround(alienPositions)) {
          userLost = true;
          return false;
        }

        if (alien.isTouchingShip(alienPositions, spaceship.getHeight(), spaceship.getLeft(), spaceship.getRight())) {
          userLost = true;
          return false;
        }
        return false;
      }
    }

    //else user has won    
    return true;
  }

  /** gets number of next level */
  int getNextLevel() {
    //if (!(level >=3))
    return level;
    //return 0;
  }

  /** gets the curret number of lives left */
  int getNumOfLives() {
    return numOfLives;
  }

  /** resets counter for next level */
  int resetTime() {
    return count;
  }

  /** Lives decrease by 1 when user loses*/
  int decreaseLife() {
    //if 3 lives, decrease to 2
    if (numOfLives == 3) {
      return numOfLives = 2;
    }
    //if 2 lives, decrease to 1
    if (numOfLives == 2)
      return numOfLives = 1 ;

    //if 1 life, decrease to 0
    if (numOfLives == 1)
      return numOfLives= 0;

    return 0; //if zero lives
  }

  /** displays "GAME OVER" sign*/
  void displayGameOver() {
    image(gameOver, 15, 100, 600, 400);
  }

  /** displays "YOU WIN sign */
  void displayYouWin() {
    image(youWin, 100, 100, 400, 300);
  }

  /** displays "YOU LOSE" sign */
  void displayYouLose() {
    image(youLose, 35, 250, 550, 90);
  }

  /** displays the text to return to the main men */
  void displaySelectMenu() {
    image(selectMenu, mLeft, mTop, mWidth, mHeight);
  }

  /** displays neon box around menu*/
  void displayNeonBoxMenu() {
    image(neonBox, neonLeft+70, neonTop+100, neonWidth-145, neonHeight);
    image(neonBox, neonLeft+70, neonTop+100, neonWidth-145, neonHeight);
  }

  /** displays text on top of screen */
  void displayText() {
    image(level3Sign, 250, 0, 100, 30);      //draws level3 sign
    image(scoreSign, 0, 0, 100, 30);         //draws score
    image(livesSign, 500, 0, 100, 30);       //draws lives
  }

  /** display number of hearts*/
  void displayHearts() {
    if (numOfLives == 0)  return;              //displays nothing if zero lives

    if (numOfLives == 3) {
      image(heart, heartL, heartT, heartW, heartH);    //heart closest to "lives" sign
      image(heart, heartL-30, heartT, heartW, heartH);
      image(heart, heartL-60, heartT, heartW, heartH);
    }
    if (numOfLives == 2) {
      image(heart, heartL, heartT, heartW, heartH);
      image(heart, heartL-30, heartT, heartW, heartH);
    }

    if (numOfLives == 1)
      image(heart, heartL, heartT, heartW, heartH);
  }

  /** draws neon box if mouse is on menu button */
  boolean mouseOnMenu() {
    if ((mouseX >= mLeft && mouseX <= mLeft+mWidth)
      && (mouseY >= mTop && mouseY <= mTop+mHeight)) {

      //go to main menu if main menu button pressed
      if (mousePressed == true) 
        level = 0; 

      return true;
    }
    return false;
  }
}
