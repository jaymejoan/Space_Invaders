/** Level class */

public class Level1 {
  PImage background, gameOver, youWin, youLose, selectContinue, selectMenu, neonBox, level1Sign, scoreSign, livesSign, heart;                      

  // Spaceship 
  Spaceship spaceship;                                                                                     //spaceship object
  float spaceshipLeft=250, spaceshipTop=700, spaceshipWidth=100, spaceshipHeight=70, spaceshipCentre=50;   //dimensions of spaceship

  // Alien
  Alien alien;                                              //alien object
  float[][] alienPositions;                                 //2D array of aliens' positions
  float alienLeft, alienRight, alienBottom;                 //dimensions ofint currentAlien; //index of alien to be removed 

  // Bullet
  Bullet bullet, currentBullet;                             //bullet objects
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();      //array list of bullets
  float bulletW = 7, bulletH = 20, bulletSpeed = 10;        //dimensions of bullet
  boolean shooting = false;                                 //user has not shot bullet

  // Heart
  float heartL = 460, heartT = 0, heartW = 40, heartH = 33;
  
  // Score
  Score sObject;

  float speed = 9.0;                                                                        //speed of the spaceship
  float vx = speed;                                                                         //horizontal speed of the spaceship
  int count, level, numOfLives, lose = 0, initialiser = 0, currentScore;                    //num of counts since starting the program, current level, num of lives                                                
  boolean hasWon = false, userLost = false;                                                 //user has not won the game

  // Select continue and menu button
  float cLeft = 185, cTop = 480, cWidth = 240, cHeight = 65;                             //dimensions of continue box
  float mLeft = cLeft+45, mTop = cTop + 100, mWidth = 150, mHeight = 65;                 //dimensions of menu box
  float neonLeft = 102, neonTop = cTop-45, neonWidth = 430, neonHeight = 160;            //dimensions of neon box

  // Constructor
  Level1(int num, String bg, String yWin, String yLose, String gOver, 
    String c, String m, String nb, String score, String l, String h, 
    String l1, Alien a, float[][] alienPos, Score scoreObject) {
    // Level1(int num, String bg, String yWin, String yLose, String gOver, 
    //String c, String m, String nb, String score, String l, String h, 
    //String l1, Alien a) {
    level = num;
    background = loadImage(bg);
    youWin = loadImage(yWin);
    youLose = loadImage(yLose);
    gameOver = loadImage(gOver);
    selectContinue = loadImage(c);
    selectMenu = loadImage(m);
    neonBox = loadImage(nb);
    scoreSign = loadImage(score);
    livesSign = loadImage(l);
    heart = loadImage(h);
    level1Sign = loadImage(l1);
    //lives = numOfLives;              //starts with 3
    alien = a;
    alienPositions = alienPos;
    sObject = scoreObject;
  }

  /** Draws Level 1 Interface */
  //void redraw(int counter, int lives, float[][] alienPos) {
  void redraw(int counter, int lives) {
    //alienPositions = alienPos;
    background(0);
    image(background, 0, 0, 600, 800);   //draws background
    count = counter;  
    if (initialiser == 0) {
      numOfLives = lives;
      currentScore = sObject.getCurrentScore();
      println("L1 start score: " + currentScore);
    }
    
    displayText();
    displayHearts();
    sObject.drawScore();

    keyPressed();                       // initiates key listener

    //constructs spaceship 
    spaceship = new Spaceship("spaceship1.png", spaceshipLeft, spaceshipTop, spaceshipWidth, spaceshipHeight);

    //displays spaceship and aliens
    spaceship.display(); 
    alien.displayAliens(alienPositions);

    moveAliens();                       //moves aliens
    showBullet();                       //displays bullet

    //if bullet is hitting an alien, remove alien and bullet
    if (isHittingAlien()) {
      sObject.addScore(10);                      //adds score
      //currentScore += 10;
      currentScore = sObject.getCurrentScore();  //updates score
      println("l1 new score: " + currentScore);
      doCollisions(currentBullet, currentAlien);
    }

    //if user has won, end game
    if (hasWon()) {
      displayYouWin();
      displaySelectContinue();
      displaySelectMenu();

      //increases level if player selects "continue"
      if (mouseOnContinue()) 
        displayNeonBoxContinue();


      //goes back to main menu if player selects "menu"
      if (mouseOnMenu()) 
        displayNeonBoxMenu();
    }

    //if player loses, decrease life
    if (userLost) {
      //decreases life by 1
      if (lose == 1) {
        numOfLives = decreaseLife();
        displayHearts();
      }
      lose++ ;              //num of times userLost is called
      //numOfLives -= 1;
      if (numOfLives == 0)
        displayGameOver();
      else {
        displayYouLose();
        displaySelectContinue();

        if (mouseOnContinue()) 
          displayNeonBoxContinue();
      }
      displaySelectMenu();

      if (mouseOnMenu()) {
        displayNeonBoxMenu();
      }
    }
    initialiser++; //increments the count
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
    if (shooting) {
      for (int i=0; i<bullets.size(); i++) {
        bullets.get(i).displayBullet();
        bullets.get(i).moveBullet();

        //removes bullet if goes off the top of the screen
        if (bullets.get(i).getY() <= -5) {
          bullets.remove(bullets.get(i));
          //println(bullets.size());
        }
      }
    }
  }

  /** Moves aliens on screen */
  void moveAliens() {
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
      rect(alienR, alienB, 5, 5);
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
      //alien.clearPositions(alienPositions);
      userLost = true;
      return false;
    }

    for (int i=0; i<alienPositions.length; i++) {
      if (alienPositions[i]!=null) {
        //if (alien.getBottom(alienPositions, i)>=630) {
        if (alien.isTouchingGround(alienPositions)) {
          //println("touching ground");
          //println("index: " + i);
          userLost = true;
          //numOfLives -= 1;
          return false;
        }
        //println(i);
        //if (spaceship.isTouching(alien.getBottom(alienPositions, i), alien.getLeftSide(alienPositions, i), alien.getRightSide(alienPositions, i))) {
        //if (alien.isTouchingShip(i, spaceship.getHeight(), spaceship.getLeft(), spaceship.getRight())) {
        if (alien.isTouchingShip(alienPositions, spaceship.getHeight(), spaceship.getLeft(), spaceship.getRight())) {
          //println("touching ship");
          userLost = true;
          return false;
        }
        //numOfLives -= 1;
        return false;
      }
      //println(i);
      //println("not empty list");
    }

    //else user has won    
    return true;
  }

  /** gets number of next level */
  int getNextLevel() {
    return level;
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


  /** gets the curret number of lives left */
  int getNumOfLives() {
    return numOfLives;
  }

  /** gets current position of aliens */
  float[][] getCurrentPositions() {
    return alienPositions;
  }
  /** displays "GAME OVER" sign*/
  void displayGameOver() {
    image(gameOver, 15, 100, 600, 400);
  }

  /** displays "YOU WIN sign */
  void displayYouWin() {
    image(youWin, 95, 100, 400, 300);
  }

  /** displays "YOU LOSE" sign */
  void displayYouLose() {
    image(youLose, 35, 250, 550, 90);
  }

  /** displays the text to continue playing */
  void displaySelectContinue() {
    image(selectContinue, cLeft, cTop, cWidth, cHeight);
  }

  /** displays the text to return to the main men */
  void displaySelectMenu() {
    image(selectMenu, mLeft, mTop, mWidth, mHeight);
  }

  /** displays neon box around continue*/
  void displayNeonBoxContinue() {
    image(neonBox, neonLeft, neonTop, neonWidth, neonHeight);
    image(neonBox, neonLeft, neonTop, neonWidth, neonHeight);
  }

  /** displays neon box around menu*/
  void displayNeonBoxMenu() {
    image(neonBox, neonLeft+70, neonTop+100, neonWidth-145, neonHeight);
    image(neonBox, neonLeft+70, neonTop+100, neonWidth-145, neonHeight);
  }

  /** displays level 1 sign */
  void displayText() {
    image(level1Sign, 250, 0, 100, 30);      //draws Level1 sign
    image(scoreSign, 0, 0, 100, 30);         //draws score
    image(livesSign, 500, 0, 100, 30);       //draws lives
  }

  /** display number of hearts*/
  void displayHearts() {
    //image(heart, heartL, heartT, heartW, heartH);    //heart closest to "lives" sign
    //image(heart, heartL-30, heartT, heartW, heartH);
    //image(heart, heartL-60, heartT, heartW, heartH);

    if (numOfLives == 0)  return;              //displays nothing if zero lives

    if (numOfLives == 3) {
      image(heart, heartL, heartT, heartW, heartH);    //heart closest to "lives" sign
      image(heart, heartL-30, heartT, heartW, heartH);
      image(heart, heartL-60, heartT, heartW, heartH);
    }
    if (numOfLives == 2) {
      println("display 2 hearts");
      image(heart, heartL, heartT, heartW, heartH);
      image(heart, heartL-30, heartT, heartW, heartH);
    }

    if (numOfLives == 1) {
      println("display 1 heart");
      image(heart, heartL, heartT, heartW, heartH);
    }
    //lose = 0;
  }


  /** draws neon box if mouse is on continue button */
  boolean mouseOnContinue() {
    if ((mouseX >= cLeft && mouseX <= cLeft+cWidth)
      && (mouseY >= cTop && mouseY <= cTop+cHeight)) {

      //go to next level if continue button selected
      if (mousePressed == true) {
        if (level == 1) {
          level = 2;
          count = 0; //resets counter
        }
      }

      return true;
    }
    return false;
  }

  /** draws neon box if mouse is on menu button */
  boolean mouseOnMenu() {
    if ((mouseX >= mLeft && mouseX <= mLeft+mWidth)
      && (mouseY >= mTop && mouseY <= mTop+mHeight)) {

      //go to main menu if main menu button pressed
      if (mousePressed == true) {
        level = 0; 
        //println("main menu selected");
      }
      return true;
    }

    return false;
  }
}
