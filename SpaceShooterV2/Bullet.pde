/** Bullet class */
public class Bullet {
  float x, y, bulletWidth, bulletHeight, speedX, speedY;


  // Constructor
  Bullet(float startX, float startY, float w, float h, float tempSpeedY) {
    x = startX;
    y = startY;
    bulletWidth = w;
    bulletHeight = h;
    speedY = tempSpeedY;
  }


  // display bullet
  void displayBullet() {
    fill(255);
    noStroke();
    rect(x, y, bulletWidth, bulletHeight);
  }

  // move bullet
  void moveBullet() {
    y -= speedY;
  }

  //return x (left) value
  float getX() {
    return x;
  }

  // return y (top) value
  float getY() {
    return y;
  }

  //return right side of bullet
  float getRight() {
    return x+bulletWidth;
  }
}
