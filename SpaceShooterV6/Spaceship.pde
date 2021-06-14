/** Spaceship class */
public class Spaceship {
  final PImage spaceshipObject;
  float left, top, spaceWidth, spaceHeight, centre, right; //dimensions of the spaceship
  //float left, top=700, spaceWidth=100, spaceHeight=70, sCentre=50;   //dimensions of spaceship
  float speed = 0.9;
  float vx = speed; //horizontal speed of spaceship

  /** Constructor */
  Spaceship(String name, float l, float t, float w, float h) {
    spaceshipObject = loadImage(name);
    left = l;
    top = t;
    spaceWidth = w;
    spaceHeight = h;
    //right = left+spaceWidth;
    //centre = c;
  }

  /** Displays the spaceship on screen */
  void display() {
    image(spaceshipObject, left, top, spaceWidth, spaceHeight);
    fill(255, 0, 0);
    rect(left, top, 5, 5);
    rect(left+95, top, 5, 5);
    rect(left, top+spaceHeight, 5,5);
    rect(left+95, top+spaceHeight, 5, 5);
    rect(left+47, top, 5, 5);
    
    //point(lespaceWidth);
    //point(spaceHeight);
  }

  /** Moves spaceship right */
  void moveRight() {
    left += vx;
    //image(spaceshipObject, left, top, spaceWidth, spaceHeight);
  }

  /** Moves spaceship left */
  void moveLeft() {
    left -= vx;
    //image(spaceshipObject, left, top, spaceWidth, spaceHeight);
  }
  
  /** Increases ship's speed if blue power up is gained */
  void increaseSpeed(){
    speed += 2;
    println("new speed: " + speed);
  }

  /** Checks if spaceship is touching an alien */
  boolean isTouching(float alienBottom, float alienLeft, float alienRight) {
    //println("bottom: " + alienBottom);
    //float right = left+95;
    //println("left: " + alienLeft);
    //println("right: " + alienRight);
    //max LHS: left = -2.0, right = 93
    //max RHS: left = 502, right = 597
    //println("space left: " + left);
    //println("space right: " + right);
    
    //need to add loop
    fill(255);
    rect(alienLeft, alienBottom, 15, 15);
    fill(255, 0, 0);
    rect(alienRight, alienBottom, 5, 5);
    //if (alienBottom>=530 && (left >= alienLeft && right <= alienRight)){
    //  return true;
    //}
    return false;
  }
   
  /** Returns height of spaceship */
  float getHeight() {
    return top;
  }

  /** Returns left of spaceship */
  float getLeft() {
    return left;
  }

  /** Returns right of spaceship */
  float getRight() {
    return left+spaceWidth;
  }





  /** Gets new position of spaceship */
  //Spaceship getNewPos(){
  //  return new Spaceship("spaceship1.png", left, top, spaceWidth, spaceHeight);
  //}
}
