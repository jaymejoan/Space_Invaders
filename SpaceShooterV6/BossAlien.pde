/** Boss alien class */
public class bossAlien {

  PImage bossAlien;
  //Level3 L3;    //used to access level 3's counter
  //float left = 150, top = 0, bossWidth = 300, bossHeight = 100;
  float left, top, right, bossWidth, bossHeight, speed = 4;
  int count;

  // Constuctor
  //bossAlien(float l, float t, float w, float h, Level3 l3Object) {
  bossAlien(float l, float t, float w, float h) {
    left = l;
    top = t;
    bossWidth = w;
    bossHeight = h;
    //L3 = l3Object;
  }

  /** Displays boss alien */
  void displayBossAlien() {
    image(loadImage("orangeAlien.png"), left, top, bossWidth, bossHeight);
    fill(255);
    rect(left+8, top, 10, 10);
    rect(left+bossWidth+8, top, 10, 10);
    fill(0, 255, 0);
    rect(left+8, top+bossHeight-15, 10, 10);
    fill(0, 0, 255);
    rect(left+bossWidth-20, top+bossHeight-15, 10, 10);
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
  
    /** removes boss alien */
  void removeBoss() {
    image(loadImage("orangeAlien.png"), left+800, top, bossWidth, bossHeight);
  }

  /** gets left side of alien */
  float getBossLeft(){
    return left+8;
  }
  
  /** gets right side of alien */
  float getBossRight(){
    return left+bossWidth-20;
  }
  
  /** gets bottom of alien */
  float getBossBottom(){
    return top+bossHeight-15;
  }
  
  /** checks if boss alien is touching the ground */
  boolean isTouchingGround() {
    if (top+bossHeight >= 800) 
      return true;
    return false;
  }

  /** checks if boss alien is touching the spaceship */
  boolean isTouchingShip(float spaceHeight, float spaceLeft, float spaceRight) {
    if ((top+bossHeight-15 >= spaceHeight) && (spaceLeft>= left+8 && spaceRight<= left+bossWidth-20))
      return true;


    return false;
  }
}
