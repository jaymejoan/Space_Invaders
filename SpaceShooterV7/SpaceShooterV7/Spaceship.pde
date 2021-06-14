/** Spaceship class */
public class Spaceship {
  final PImage spaceshipObject;
  float left, top, spaceWidth, spaceHeight, centre, right, speed = 0.9, vx = speed; //dimensions of the spaceship
  

  // Constructor
  Spaceship(String name, float l, float t, float w, float h) {
    spaceshipObject = loadImage(name);
    left = l;
    top = t;
    spaceWidth = w;
    spaceHeight = h;
    
  }

  /** Displays the spaceship on screen */
  void display() {
    image(spaceshipObject, left, top, spaceWidth, spaceHeight);
  }

  /** Moves spaceship right */
  void moveRight() {
    left += vx;
  }

  /** Moves spaceship left */
  void moveLeft() {
    left -= vx;
  }

  /** Increases ship's speed if blue power up is gained */
  void increaseSpeed() {
    speed += 2;
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
}
