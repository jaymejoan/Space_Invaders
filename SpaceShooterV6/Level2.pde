/** Level class */

public class Level2 {
  PImage background, gameOver, youWin, youLose, selectContinue, selectMenu, neonBox, level2Sign, scoreSign, livesSign, heart;                  

  // Spaceship 
  Spaceship spaceship;                                                                                     //spaceship object
  float spaceshipLeft=250, spaceshipTop=700, spaceshipWidth=100, spaceshipHeight=70, spaceshipCentre=50;   //dimensions of spaceship

  // Alien
  Alien alien;                                              //alien object
  float[][] alienPositions;                                 //2D array of aliens' positions
  float alienLeft, alienRight, alienBottom;                 //dimensions ofint currentAlien; //index of alien to be removed 


  //Bullet
  Bullet bullet, currentBullet;                         //bullet objects
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();      //array list of bullets
  float bulletW = 10, bulletH = 20, bulletSpeed = 10;       //dimensions of bullet
  boolean shooting = false;                                 //user has not shot bullet

  // Heart
  float heartL = 460, heartT = 0, heartW = 40, heartH = 33;

  //Score
  Score sObject;
  boolean hasWon = false, userLost = false, showRedPowerUp = true, showBluePowerUp = true;  //user has not won the game
  float speed = 9.0, rTimeRed, rTimeRed2, rTimeBlue;                                                   //speed of the spaceship, random times for powerup
  float vx = speed;                                          //horizontal speed of the spaceshipfloat speed = 9.0, rTimeRed, rTimeRed2, rTimeBlue;                                                   //speed of the spaceship, random times for powerup
  int count, level, numOfLives, lose = 0, initialiser = 0, currentScore;                    //num of counts since starting the program, current level, num of lives           


  // Select continue and menu button
  float cLeft = 185, cTop = 480, cWidth = 240, cHeight = 65;                             //dimensions of continue box
  float mLeft = cLeft+45, mTop = cTop + 100, mWidth = 150, mHeight = 65;                      //dimensions of menu box
  float neonLeft = 102, neonTop = cTop-45, neonWidth = 430, neonHeight = 160;            //dimensions of neon box


  // Constructor
  Level2(int num, String bg, String yWin, String yLose, String gOver, String c, String m, String nb, String l2, String s, String l, String h, Alien a, float[][] alienPos, Score scoreObject) {
    //Level2(int num, String bg, String yWin, String gOver, String c, String m, String nb, String l2, String s, String l, Alien a) {
    level = num;
    background = loadImage(bg);
    youWin = loadImage(yWin);
    youLose = loadImage(yLose);
    gameOver = loadImage(gOver);
    selectContinue = loadImage(c);
    selectMenu = loadImage(m);
    neonBox = loadImage(nb);
    level2Sign = loadImage(l2);
    scoreSign = loadImage(s);
    livesSign = loadImage(l);
    heart = loadImage(h);
    alien = a;
    alienPositions = alienPos;
    sObject = scoreObject;
    rTimeRed= (int)random(100, 300);    //randomly generated time for the red powerup to appear
    rTimeRed2 = (int)random(400, 600);    //randomly generated time for the red powerup to appear
    rTimeBlue = (int)random(200, 700);   //randomly generated time for the blue powerup to appear
  }

  /** Draws Level 2 Interface */
  //void redraw(int counter, int lives, float[][] alienPos) {
  void redraw(int counter, int lives) {
    background(0);
    image(background, 0, 0, 600, 800);   //draws background
    displayText();
    displayHearts();
    count = counter; 
    //currentScore = score;

    //sets initial score once
    if (initialiser == 0) {
      currentScore = sObject.getCurrentScore();
      println("L2 start score: " + currentScore);
    }

    //sets initial life once
    if (lose == 0)
      numOfLives = lives;

    sObject.drawScore();

    keyPressed();                       // initiates key listener

    //constructs spaceship 
    spaceship = new Spaceship("spaceship1.png", spaceshipLeft, spaceshipTop, spaceshipWidth, spaceshipHeight);

    //displays spaceship and aliens
    spaceship.display(); 
    //if (level == 1)
    alien.displayAliens2(alienPositions);

    moveAliens();                       //moves aliens
    alien.shootBullets(0, 400, alienPositions, initialiser, bullet, alien); //enables aliens to randomly shoot
    //void shootBullets(float min, float max, float[][] alienPos, int count, Bullet bullet, Alien alien){}
    showBullet();                       //displays spaceship bullet

    //if bullet is hitting an alien, remove alien and bullet
    if (isHittingAlien()) {
      sObject.addScore(10);                      //adds score
      currentScore += 10;
      currentScore = sObject.getCurrentScore();  //updates score
      //println("L2 new score: " + currentScore);
      doCollisions(currentBullet, currentAlien);
    }

    //display red power-up and checks if spaceship is hitting it
    if (initialiser >= rTimeRed || initialiser >= rTimeRed2) {
      if (showRedPowerUp && !hasWon && !userLost) {
        //println("display red power up");
        sObject.displayRedPowerUp();
        if (sObject.isHittingRedpowerUp(spaceship.getLeft(), spaceship.getRight())) {
          //println("don't display power up");
          showRedPowerUp = false;
          sObject.addScore(30);
          //sObject.removeRedPowerUp();
        }
      }
    }

    //display power-ups and checks if spaceship is hitting them
    if (initialiser >= rTimeBlue) {
      if (showBluePowerUp && !hasWon && !userLost) {
        //println("display blue power up");
        sObject.displayBluePowerUp();
        if (sObject.isHittingBluepowerUp(spaceship.getLeft(), spaceship.getRight())) {
          //println("don't display power up");
          showBluePowerUp = false;
          sObject.addScore(50);
          spaceship.increaseSpeed();
          //sObject.removeBluePowerUp();
        }
      }
    }


    ////if user has won, end game
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

    //if aliens reach the end of the screen, player loses
    if (userLost) {
      //decreases life by 1
      if (lose == 1)
        numOfLives = decreaseLife();

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
      //alien.clearPositions(alienPositions);
      userLost = true;
      return false;
    }

    for (int i=0; i<alienPositions.length; i++) {
      if (alienPositions[i]!=null) {
        //if (alien.getBottom(alienPositions, i)>=630) {
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
      println("change lives from 3 to 2");
      return numOfLives = 2;
    }
    //if 2 lives, decrease to 1
    if (numOfLives == 2) {
      println("change lives from 2 to 1");
      return numOfLives = 1 ;
    }
    //if 1 life, decrease to 0
    if (numOfLives == 1) {
      println("change lives from 1 to 0");
      return numOfLives= 0;
    }
    return 0; //if zero lives
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

  /** displays text on top of screen */
  void displayText() {
    image(level2Sign, 250, 0, 100, 30);      //draws level2 sign
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

  /** draws neon box if mouse is on continue button */
  boolean mouseOnContinue() {
    if ((mouseX >= cLeft && mouseX <= cLeft+cWidth)
      && (mouseY >= cTop && mouseY <= cTop+cHeight)) {

      //go to next level if continue button selected
      if (mousePressed == true) {
        //if user already on final level, return to menu

        //this.level++; 

        //determines level
        if (level == 2) {
          level = 3;
          count = 0;
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
