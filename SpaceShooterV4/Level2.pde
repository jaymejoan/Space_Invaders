/** Level class */

public class Level2 {
  PImage background, gameOver, youWin, selectContinue, selectMenu, neonBox, level2Sign, scoreSign, livesSign;                      

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

  float speed = 9.0;                                         //speed of the spaceship
  float vx = speed;                                          //horizontal speed of the spaceship
  int count, level, numOfLives;                                   //num of counts since starting the program, current level, num of lives 
  boolean hasWon = false, userLost = false;                  //user has not won the game

  // Select continue and menu button
  float cLeft = 185, cTop = 480, cWidth = 240, cHeight = 65;                             //dimensions of continue box
  float mLeft = cLeft+45, mTop = cTop + 100, mWidth = 150, mHeight = 65;                      //dimensions of menu box
  float neonLeft = 102, neonTop = cTop-45, neonWidth = 430, neonHeight = 160;            //dimensions of neon box


  // Constructor
  Level2(int num, String bg, String yWin, String gOver, String c, String m, String nb, String l2, String s, String l, Alien a, float[][] alienPos) {
    level = num;
    background = loadImage(bg);
    youWin = loadImage(yWin);
    gameOver = loadImage(gOver);
    selectContinue = loadImage(c);
    selectMenu = loadImage(m);
    neonBox = loadImage(nb);
    level2Sign = loadImage(l2);
    scoreSign = loadImage(s);
    livesSign = loadImage(l);
    alien = a;
    alienPositions = alienPos;
  }

  /** Draws Level 2 Interface */
  void redraw(int counter, int lives) {
    background(0);
    image(background, 0, 0, 600, 800);   //draws background
    displayText();

    //spaceship = sp;                    //updates spaceship object
    //println(count);
    numOfLives = lives;
    count = counter; 
    //println("level 2 reached");

    keyPressed();                       // initiates key listener

    //constructs spaceship 
    spaceship = new Spaceship("spaceship1.png", spaceshipLeft, spaceshipTop, spaceshipWidth, spaceshipHeight);

    //displays spaceship and aliens
    spaceship.display(); 
    //if (level == 1)
    alien.displayAliens2(alienPositions);

    moveAliens();                       //moves aliens
    showBullet();                       //displays bullet

    //println("current level: " + level);

    //displayYouWin();
    //displaySelectContinue();
    //displaySelectMenu();
    //image(neonBox, neonLeft, neonTop, neonWidth, neonHeight);
    //image(neonBox, neonLeft+70, neonTop+100, neonWidth-145, neonHeight);
    //println("left: " + alien.getLeftPos());
    //println("right: " + alien.getRightPos());
    //image(loadImage("alien.png"), 24, 700, 100, 50);

    ////if bullet is hitting an alien, remove alien and bullet
    if (isHittingAlien()) 
      doCollisions(currentBullet, currentAlien);

    ////if user has won, end game
    if (hasWon()) {
      displayYouWin();
      displaySelectContinue();
      displaySelectMenu();

      //increases level if player selects "continue"
      if (mouseOnContinue()) {
        image(neonBox, neonLeft, neonTop, neonWidth, neonHeight);
        image(neonBox, neonLeft, neonTop, neonWidth, neonHeight);
      }

      //goes back to main menu if player selects "menu"
      if (mouseOnMenu()) {
        image(neonBox, neonLeft+70, neonTop+100, neonWidth-145, neonHeight);
        image(neonBox, neonLeft+70, neonTop+100, neonWidth-145, neonHeight);
      }
    }
    //if aliens reach the end of the screen, player loses
    if (userLost) {
      displayGameOver();
      displaySelectMenu();

      if (mouseOnMenu()) {
        image(neonBox, neonLeft+70, neonTop+100, neonWidth-145, neonHeight);
        image(neonBox, neonLeft+70, neonTop+100, neonWidth-145, neonHeight);
      }
    }
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
    for (int i=0; i<alienPositions.length; i++) {
      if (alienPositions[i]!=null) {
        //println(i);
        if (alien.getBottom(alienPositions, i)>=630) {
          userLost = true;
          return false;
        }
        //println(i);
        if (spaceship.isTouching(alien.getBottom(alienPositions, i), alien.getLeftSide(alienPositions, i), alien.getRightSide(alienPositions, i))) {
          //if (alien.isTouching(i, spaceship.getHeight(), spaceship.getLeft(), spaceship.getRight())) {
          userLost = true;
          return false;
        }
        //println(i);
        //println("not empty list");
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

  /** resets counter for next level */
  int resetTime() {
    return count;
  }

  /** displays "GAME OVER" sign*/
  void displayGameOver() {
    image(gameOver, 15, 100, 600, 400);
  }

  /** displays "YOU WIN sign */
  void displayYouWin() {
    image(youWin, 95, 100, 400, 300);
  }

  /** displays the text to continue playing */
  void displaySelectContinue() {
    image(selectContinue, cLeft, cTop, cWidth, cHeight);
  }

  /** displays the text to return to the main men */
  void displaySelectMenu() {
    image(selectMenu, mLeft, mTop, mWidth, mHeight);
  }

  /** displays text on top of screen */
  void displayText() {
    image(level2Sign, 250, 0, 100, 30);      //draws level2 sign
    image(scoreSign, 0, 0, 100, 30);         //draws score
    image(livesSign, 500, 0, 100, 30);       //draws lives
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
            //clear();
            level = 3;
            count = 0;
          }
          //if (level == 2)
          //  this.level = 3;
          //if (level == 3)
          //  this.level = 0;
          //else
          //this.level = 0;


          //println("next level: " + level);
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
          println("main menu selected");
        }
        return true;
      }

      return false;
    }
  }
