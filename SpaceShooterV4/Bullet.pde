/** Bullet class */
public class Bullet {
  float x, y, bulletWidth, bulletHeight, speedX, speedY;
  //ArrayList<Bullet> bullets = new ArrayList<Bullet>(); //array list of bullets


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

  // add new bullet to list
  //void addNewBullet(Bullet b) {
  //  bullets.add(b);
  //}

  // move bullet
  void moveBullet() {
    y -= speedY;
  }

  // shows bullet moving if fired
  //void showBullet() {
  //  //for (int i=0; i<bullets.size(); i++) {
  //  //  bullets.get(i).displayBullet();
  //  //  bullets.get(i).moveBullet();

  //  //}
  //  for (int i=0; i<bullets.size(); i++) {
  //    bullets.get(i).displayBullet();
  //    bullets.get(i).moveBullet();

  //    //removes bullet if goes off the top of the screen
  //    if (bullets.get(i).getY() <= -5) 
  //      bullets.remove(bullets.get(i));
  //    }
  //  }

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

//    //returns list of bullets
//    ArrayList<Bullet> getListOfBullets() {
//      return bullets;
//    }
  }
