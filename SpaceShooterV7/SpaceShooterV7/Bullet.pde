/** Bullet class */
public class Bullet {
  float x, y, bulletWidth, bulletHeight, speedX, speedY;      // dimensions of bullet

  // Constructor
  Bullet(float startX, float startY, float w, float h, float tempSpeedY) {
    x = startX;
    y = startY;
    bulletWidth = w;
    bulletHeight = h;
    speedY = tempSpeedY;
  }


  /** Display bullet */
  void displayBullet() {
    fill(255);
    noStroke();
    rect(x, y, bulletWidth, bulletHeight);
  }

  /** Move bullet */
  void moveBullet() {
    y -= speedY;
  }

  /** Return x (left) value */
  float getX() {
    return x;
  }

  /** Return y (top) value */
  float getY() {
    return y;
  }

  /** Return right side of bullet */
  float getRight() {
    return x+bulletWidth;
  }

}
