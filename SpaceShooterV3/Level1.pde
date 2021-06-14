/** Level class */

public class Level1 {
  PImage background, gameOver, youWin;                      

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
  int count;                                                 //num of counts since starting the program
  boolean hasWon = false, userLost = false;                  //user has not won the game
  int level;                                                 // current level number


  // Constructor
  Level1(int num, String bg, String yWin, String gOver, Alien a, float[][] alienPos) {
    level = num;
    background = loadImage(bg);
    youWin = loadImage(yWin);
    gameOver = loadImage(gOver);
    alien = a;
    alienPositions = alienPos;
  }

  /** Draws Level 1 Interface */
  void redraw(int counter) {
    image(background, 0, 0, 600, 800);   //draws background
    //spaceship = sp;                    //updates spaceship object
    count = counter; 

    keyPressed();                       // initiates key listener

    //constructs spaceship 
    spaceship = new Spaceship("spaceship1.png", spaceshipLeft, spaceshipTop, spaceshipWidth, spaceshipHeight);

    //displays spaceship and aliens
    spaceship.display(); 
    alien.displayAliens();

    moveAliens();                       //moves aliens
    showBullet();                       //displays bullet 
    

    //println("left: " + alien.getLeftPos());
    //println("right: " + alien.getRightPos());
    //image(loadImage("alien.png"), 24, 700, 100, 50);

    ////if bullet is hitting an alien, remove alien and bullet
    if (isHittingAlien()) 
      doCollisions(currentBullet, currentAlien);

    ////if user has won, end game
    if (hasWon()) 
      displayYouWin();

    //if aliens reach the end of the screen, player loses
    if (userLost) 
      displayGameOver();
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
          println(bullets.size());
        }
      }
    }
  }


  /** Moves aliens on screen */
  void moveAliens() {
    if (count>=0 && count<=30) 
      alien.moveRight();  //move right
    else if (count>=31 && count<=41)  
      alien.moveDown();  //move down
    else if (count >=42 && count <=72)
      alien.moveLeft();  //move left
    else if (count<=82)
      alien.moveDown();  //move down
  }

  /** method returns true if bullet is hitting an alien */
  boolean isHittingAlien() {

    for (int i=0; i<alienPositions.length; i++) {
      //gets the left, right and bottom of current alien in array
      float alienL = alien.getLeftSide(i);
      float alienR = alien.getRightSide(i);
      float alienB = alien.getBottom(i);

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
        if (alien.getBottom(i)>=630) {
          userLost = true;
          return false;
        }
        if (spaceship.isTouching(alien.getBottom(i), alien.getLeftSide(i), alien.getRightSide(i))) {
        //if (alien.isTouching(i, spaceship.getHeight(), spaceship.getLeft(), spaceship.getRight())) {
          userLost = true;
          return false;
        }
        //println("not empty list");
        return false;
      }
    }
    //else user has won    
    return true;
  }

  /** displays "GAME OVER" sign*/
  void displayGameOver() {
    image(gameOver, 15, 100, 600, 400);
  }

  /** displays "YOU WIN sign */
  void displayYouWin() {
    image(youWin, 100, 100, 400, 300);
  }
}
