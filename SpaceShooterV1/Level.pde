/** Level class */

public class Level {
  PImage background, gameOver, youWin;

  // Spaceship 
  Spaceship spaceship; //spaceship object
  float spaceshipLeft=250, spaceshipTop=500, spaceshipWidth=100, spaceshipHeight=70, spaceshipCentre=50;   //dimensions of spaceship

  // Alien
  Alien alien; //alien object
  float[][] alienPositions; //2D array of aliens' positions
  float alienLeft, alienRight, alienBottom; //dimensions ofint currentAlien; //index of alien to be removed 


  //Bullet
  Bullet bullet, currentBullet; //bullet objects
  ArrayList<Bullet> bullets = new ArrayList<Bullet>(); //array list of bullets
  float bulletW = 10, bulletH = 20, bulletSpeed = 10; //dimensions of bullet
  boolean shooting = false; //user has not shot bullet

  float speed = 9.0; //speed of the spaceship
  float vx = speed; //horizontal speed of the spaceship
  int count; //num of counts since starting the program
  boolean hasWon = false, userLost = false; //user has not won the game
  
  int level;


  // Constructor
  Level(int num, PImage bg) {
    level = num;
    background = bg;
  }

  void redraw(int count) {
    image(background, 0, 0, 600, 600); //draws background

    //constructs spaceship 
    spaceship = new Spaceship("spaceship1.png", spaceshipLeft, spaceshipTop, spaceshipWidth, spaceshipHeight, spaceshipCentre);

    //displays spaceship and aliens
    spaceship.display(); 
    alien.displayAliens();

    moveAliens();   //moves aliens

    showBullet(); //displays bullet 


    //if bullet is hitting an alien, remove alien and bullet
    if (isHittingAlien()) 
      doCollisions(currentBullet, currentAlien);

    //if user has won, end game
    if (hasWon()) {
      displayYouWin();
      println("win");
    } 

    //if aliens reach the end of the screen, player loses
    if (userLost) {
      displayGameOver();
      println("lose");
    }
  }

  /** Moves the spaceship and shoots using the mouse keys*/
  void keyPressed() {
    if (keyCode==LEFT && spaceshipLeft >= 0) 
      this.spaceshipLeft -= vx; 
    //spaceship.moveLeft();
    else if (keyCode==RIGHT && spaceshipWidth+spaceshipLeft<=width) 
      this.spaceshipLeft += vx; 
    // spaceship.moveRight();

    //if user shoots
    else if (keyCode==' ') {
      if (bullets!=null && bullets.size()<=2) 
        bullets.add(new Bullet(spaceshipLeft+spaceshipCentre-5, spaceshipTop-bulletH, bulletW, bulletH, bulletSpeed));
      ////bullet = new Bullet(spaceshipLeft+spaceshipCentre-5, spaceshipTop-bulletH, bulletW, bulletH, bulletSpeed);
      //bullet.addNewBullet(new Bullet(spaceshipLeft+spaceshipCentre-5, spaceshipTop-bulletH, bulletW, bulletH, bulletSpeed));

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
        if (bullets.get(i).getY() <= -5) 
          bullets.remove(bullets.get(i));
      }
    }
  }


  /** Moves aliens on screen */
  void moveAliens() {
    if (count>=0 && count<=30) 
      alien.moveRight();  //move right
    else if (count>=31 && count<=41)  
      alien.moveDown();  //move down
    else if (count >=42 && count <=71)
      alien.moveLeft();  //move left
    else if (count<=82)
      alien.moveDown();  //move down
 //   else
     // count = 0;   //reset counter to repeat process
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
        float bLeft = bullets.get(j).getX(); //x position of bullet
        float bTop = bullets.get(j).getY(); //y position of bullet
        float bRight = bullets.get(j).getRight(); //RHS of bullet

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

    for (int i=0; i<alienPositions.length; i++) {
      //if array list is not empty, user has not yet won
      if (alienPositions[i]!=null) {
        //if aliens touch the bottom of the screen, user loses
        if (alien.getBottom(i)>=height-50) {
          //println(alienPositions[i][1]);
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
    image(gameOver, 200, 200, 400, 300);
  }

  /** displays "YOU WIN sign */
  void displayYouWin() {
    image(youWin, 100, 100, 400, 300);
  }
}
