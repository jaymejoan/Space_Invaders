/** Spaceship class */
public class Spaceship {
  final PImage spaceshipObject;
  public float left, top, spaceWidth, spaceHeight, centre; //dimensions of the spaceship
  float speed = 0.9;
  float vx = speed; //horizontal speed of spaceship

  // constructor
  Spaceship(String name, float l, float t, float w, float h, float c) {
    spaceshipObject = loadImage(name);
    left = l;
    top = t;
    spaceWidth = w;
    spaceHeight = h;
    centre = c;
  }

  // Displays the spaceship on screen 
  void display() {
    image(spaceshipObject, left, top, spaceWidth, spaceHeight);
  }
  
  // Moves spaceship right
  void moveRight(){
    left += vx;
  }
  
  // Moves spaceship left
  void moveLeft(){
    left -= vx;
  
  }

}
