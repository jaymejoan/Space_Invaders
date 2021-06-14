/** Level class */

public class Level2 {
  PImage background, gameOver, youWin, youLose, selectContinue, selectMenu, neonBox, level2Sign, scoreSign, livesSign, heart;                      

  // Spaceship object and dimensions
  Spaceship spaceship;                                                                                     
  float spaceshipLeft=250, spaceshipTop=700, spaceshipWidth=100, spaceshipHeight=70, spaceshipCentre=50, speed = 9.0, vx = speed;   

  // Alien
  Alien alien;                                                                              // alien object
  float[][] alienPositions;                                                                 // 2D array of aliens' positions
  float alienLeft, alienRight, alienBottom;                                                 // dimensions ofint currentAlien; //index of alien to be removed 

  // Bullet
  Bullet bullet, currentBullet;                                                             // bullet objects
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();                                      // array list of bullets
  float bulletW = 7, bulletH = 20, bulletSpeed = 10;                                        // dimensions of bullet
  boolean shooting = false;                                                                 // user has not shot bullet

  // Heart
  float heartL = 460, heartT = 0, heartW = 40, heartH = 33;

  // Score
  Score sObject;
  boolean runMainMenu = false, userLost = false, showRedPowerUp = true, showBluePowerUp = true;  // user has not won the game
  float  rTimeRed, rTimeRed2, rTimeBlue;                                                         // random times for powerups
  int count, level, numOfLives, lose = 0, initialiser = 0, currentScore;                         // num of counts since starting the program, current level, num of lives                                                

  // Select continue and menu button
  float cLeft = 185, cTop = 480, cWidth = 240, cHeight = 65;                                 // dimensions of continue box
  float mLeft = cLeft+45, mTop = cTop + 100, mWidth = 150, mHeight = 65;                     // dimensions of menu box
  float neonLeft = 102, neonTop = cTop-45, neonWidth = 430, neonHeight = 160;                // dimensions of neon box


  // Constructor
  Level2(int num, String bg, String yWin, String yLose, String gOver, String c, String m, String nb, String l2, String s, String l, String h, Alien a, float[][] alienPos, Score scoreObject) {
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
    rTimeRed= (int)random(100, 300);   
    rTimeRed2 = (int)random(400, 600);    
    rTimeBlue = (int)random(200, 700);
  }

  /** Draws Level 2 Interface */
  void redraw(int counter, int lives) {
    background(0);
    image(background, 0, 0, 600, 800);   //draws background
    displayText();                                            // displays level number, score and lives sign
    displayHearts();                                          // displays current number of hearts
    sObject.drawScore();                                      // displays current score
    count = counter; 
    runMainMenu = false;

    //sets initial score once
    if (initialiser == 0) 
      currentScore = sObject.getCurrentScore();

    //sets initial life once
    if (lose == 0)
      numOfLives = lives;

    keyPressed();                                             // initiates key listener


    // Constructs and displays spaceship 
    spaceship = new Spaceship("spaceship1.png", spaceshipLeft, spaceshipTop, spaceshipWidth, spaceshipHeight);
    spaceship.display(); 

    // Displays and moves aliens
    alien.displayAliens2(alienPositions);
    moveAliens();                       
    showBullet();                      

    // If bullet is hitting an alien, remove alien and bullet
    if (isHittingAlien()) {
      if (!hasWon() && !userLost) {
        sObject.addScore(10);                      //adds score
        currentScore = sObject.getCurrentScore();  //updates score
      }
      doCollisions(currentBullet, currentAlien);
    }

    // Display red power-up and checks if spaceship is hitting it
    if (initialiser >= rTimeRed || initialiser >= rTimeRed2) {
      if (showRedPowerUp && !hasWon && !userLost) {
        sObject.displayRedPowerUp();
        if (sObject.isHittingRedpowerUp(spaceship.getLeft(), spaceship.getRight())) {
          //println("don't display power up");
          showRedPowerUp = false;
          sObject.addScore(30);
        }
      }
    }

    // Display blue power-up and checks if spaceship is hitting it
    if (initialiser >= rTimeBlue) {
      if (showBluePowerUp && !hasWon && !userLost) {
        sObject.displayBluePowerUp();
        if (sObject.isHittingBluepowerUp(spaceship.getLeft(), spaceship.getRight())) {
          showBluePowerUp = false;
          sObject.addScore(50);
          spaceship.increaseSpeed();
        }
      }
    }


    // if user has won, end game
    if (hasWon() && !userLost) {
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
    else if (userLost) {
      if (lose == 1)
        numOfLives = decreaseLife();                    // Decreases life by 1
      lose++ ;              
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
      keyCode = UP;                                    //changes key code (stops movement)
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

        // Removes bullet if goes off the top of the screen
        if (bullets.get(i).getY() <= -5) 
          bullets.remove(bullets.get(i));
      }
  }


  /** Moves aliens on screen */
  void moveAliens() {
    if (count>=0 && count<=20) 
      alien.moveRight(alienPositions, 3); //move right
    else if (count>=21 && count<=31)  
      alien.moveDown(alienPositions, 3);  //move down
    else if (count >=32 && count <=51)
      alien.moveLeft(alienPositions, 3);  //move left
    else if (count <= 62)
      alien.moveDown(alienPositions, 3);  //move down
    else
      count = 0;
  }

  /* Removes bullet and alien from respective lists */
  void doCollisions(Bullet b, int index) {
    bullets.remove(b);
    alienPositions[index] = null;
  }
  
  /** Displays "GAME OVER" sign*/
  void displayGameOver() {
    image(gameOver, 15, 100, 600, 400);
  }

  /** Displays "YOU WIN sign */
  void displayYouWin() {
    image(youWin, 95, 100, 400, 300);
  }

  /** Displays "YOU LOSE" sign */
  void displayYouLose() {
    image(youLose, 35, 250, 550, 90);
  }

  /** Displays the text to continue playing */
  void displaySelectContinue() {
    image(selectContinue, cLeft, cTop, cWidth, cHeight);
  }

  /** Displays the text to return to the main men */
  void displaySelectMenu() {
    image(selectMenu, mLeft, mTop, mWidth, mHeight);
  }

  /** Displays neon box around continue*/
  void displayNeonBoxContinue() {
    image(neonBox, neonLeft, neonTop, neonWidth, neonHeight);
    image(neonBox, neonLeft, neonTop, neonWidth, neonHeight);
  }

  /** Displays neon box around menu*/
  void displayNeonBoxMenu() {
    image(neonBox, neonLeft+70, neonTop+100, neonWidth-145, neonHeight);
    image(neonBox, neonLeft+70, neonTop+100, neonWidth-145, neonHeight);
  }

  /** Displays text on top of screen */
  void displayText() {
    image(level2Sign, 250, 0, 100, 30);      //draws level2 sign
    image(scoreSign, 0, 0, 100, 30);         //draws score
    image(livesSign, 500, 0, 100, 30);       //draws lives
  }

  /** Display number of hearts */
  void displayHearts() {
    if (numOfLives == 0)  return;              //displays nothing if zero lives

    if (numOfLives == 3) {
      image(heart, heartL, heartT, heartW, heartH);    
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
  
  /** Method returns true if bullet is hitting an alien */
  boolean isHittingAlien() {

    for (int i=0; i<alienPositions.length; i++) {
      //gets the left, right and bottom of current alien in array
      float alienL = alien.getLeftSide(alienPositions, i);
      float alienR = alien.getRightSide(alienPositions, i);
      float alienB = alien.getBottom(alienPositions, i);

      //checks if bullet is hitting current alien
      for (int j=0; j<bullets.size(); j++) {
        //gets the x and y position of bullet and RHS
        float bLeft = bullets.get(j).getX(); 
        float bTop = bullets.get(j).getY(); 
        float bRight = bullets.get(j).getRight(); 

        //returns true if bullet is hitting bottom of alien
        if ((bTop <= alienB) && (bRight >= alienL && bLeft <= alienR)) {
          currentBullet = bullets.get(j);                                   //bullet that needs to be removed
          currentAlien = i;                                                 //index of alien that needs to be removed
          return true;
        }
      }
    }
    return false;
  }

  /** Checks if user has won the game */
  boolean hasWon() {  
    //conditions for losing:
    if (numOfLives == 0) {                                                     // if number of lives reaches zero                                                
      userLost = true;
      return false;
    }

    for (int i=0; i<alienPositions.length; i++) {                              //if array list is not empty
      if (alienPositions[i]!=null) {
        if (alien.isTouchingGround(alienPositions)) {                          // if aliens touch the bottom of the screen
          userLost = true;
          return false;
        }

        // if spaceship is touching an alien
        if (alien.isTouchingShip(alienPositions, spaceship.getHeight(), spaceship.getLeft(), spaceship.getRight())) {    
          userLost = true;
          return false;
        }
        return false;
      }
    } 
    return true;                                                               //else user has won
  }

  /** Draws neon box if mouse is on continue button */
  boolean mouseOnContinue() {
    if ((mouseX >= cLeft && mouseX <= cLeft+cWidth)
      && (mouseY >= cTop && mouseY <= cTop+cHeight)) {

      // go to next level if continue button selected
      if (mousePressed == true) {
        if (level == 2) {
          level = 3;
          count = 0;
        }
      }
      return true;
    }
    return false;
  }

  /** Draws neon box if mouse is on menu button */
  boolean mouseOnMenu() {
    if ((mouseX >= mLeft && mouseX <= mLeft+mWidth)
      && (mouseY >= mTop && mouseY <= mTop+mHeight)) {

      // Go to main menu if main menu button pressed
      if (mousePressed == true) {
        runMainMenu = true;
        level = 0;
      }
      return true;
    }
    return false;
  }

  /** returns true if menu button is selected */
  boolean checkRunMainMenu() {
    return runMainMenu;
  }


  /** Gets number of next level */
  int getNextLevel() {
    //if (!(level >=3))
    return level;
    //return 0;
  }

  /** Gets the curret number of lives left */
  int getNumOfLives() {
    return numOfLives;
  }

  /** Resets counter for next level */
  int resetTime() {
    return count;
  }

  /** Lives decrease by 1 when user loses*/
  int decreaseLife() {
    if (numOfLives == 3)      return numOfLives = 2;
    if (numOfLives == 2)      return numOfLives = 1 ;
    if (numOfLives == 1)      return numOfLives= 0;
    return 0;
  }

}
