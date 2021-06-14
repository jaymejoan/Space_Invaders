/** Lives class */
public class Lives {
  
  PImage heart;
  int totalLives;
  
  // dimensions for heart 
  float heartL = 460, heartT = 0, heartW = 40, heartH = 33;

  Lives(int lives, String h) {
    totalLives = lives;
    heart = loadImage(h);
  }
  
  /** display number of hearts*/
  void displayHearts(int numOfLives) {
    //image(heart, heartL, heartT, heartW, heartH);    //heart closest to "lives" sign
    //image(heart, heartL-30, heartT, heartW, heartH);
    //image(heart, heartL-60, heartT, heartW, heartH);

    if (numOfLives == 0)  return;              //displays nothing if zero lives

    if (numOfLives == 3) {
      image(heart, heartL, heartT, heartW, heartH);    //heart closest to "lives" sign
      image(heart, heartL-30, heartT, heartW, heartH);
      image(heart, heartL-60, heartT, heartW, heartH);
    }
    if (numOfLives == 2) {
      println("display 2 hearts");
      image(heart, heartL, heartT, heartW, heartH);
      image(heart, heartL-30, heartT, heartW, heartH);
    }

    if (numOfLives == 1) {
      println("display 1 heart");
      image(heart, heartL, heartT, heartW, heartH);
    }
   
  }


   /** Lives decrease by 1 when user loses*/
  int decreaseLife(int numOfLives) {
    //if 3 lives, decrease to 2
    if (numOfLives == 3) {
      return totalLives = 2;
    }
    //if 2 lives, decrease to 1
    if (numOfLives == 2)
      return totalLives = 1 ;

    //if 1 life, decrease to 0
    if (numOfLives == 1)
      return totalLives = 0;

    return totalLives = 0; //if zero lives
  }

  /** gets the current score */
  int getCurrentLives(){
    return totalLives;
  }
  
  
}
