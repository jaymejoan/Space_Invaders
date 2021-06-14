/** Boss alien class */
public class bossAlien {

  PImage bossAlien;                                           
  float left, top, right, bossWidth, bossHeight, speed = 4; // dimensions of boss alien
  int count;

  // Constuctor
  bossAlien(float l, float t, float w, float h) {
    left = l;
    top = t;
    bossWidth = w;
    bossHeight = h;
  }

  /** Displays boss alien */
  void displayBossAlien() {
    image(loadImage("orangeAlien.png"), left, top, bossWidth, bossHeight);
  }

  /** Moves boss alien right */
  void moveBossRight() {
    left+=speed;
  }

  /** Moves boss alien left */
  void moveBossLeft() {
    left-=speed;
  }

  /** Moves boss alien down */
  void moveDown() {
    top+=speed;
  }

  /** Moves boss alien diagonal right */
  void moveBossDiagonalRight() {
    left+=speed;
    top+=speed;
  }

  /** Moves boss alien diagonal left */
  void moveBossDiagonalLeft() {
    left-=speed;
    top+=speed;
  }
  
    /** Removes boss alien */
  void removeBoss() {
    image(loadImage("orangeAlien.png"), left+800, top, bossWidth, bossHeight);
  }
  
  /** Checks if boss alien is touching the ground */
  boolean isTouchingGround() {
    if (top+bossHeight >= 800) 
      return true;
    return false;
  }

  /** Checks if boss alien is touching the spaceship */
  boolean isTouchingShip(float spaceHeight, float spaceLeft, float spaceRight) {
    if ((top+bossHeight-15 >= spaceHeight) && (spaceLeft>= left+8 && spaceRight<= left+bossWidth-20))
      return true;

    return false;
  }

  /** Gets left side of alien */
  float getBossLeft(){
    return left+8;
  }
  
  /** Gets right side of alien */
  float getBossRight(){
    return left+bossWidth-20;
  }
  
  /** Gets bottom of alien */
  float getBossBottom(){
    return top+bossHeight-15;
  }
  
}
