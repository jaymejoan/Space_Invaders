/** Lives class */
public class Lives {
  
  PImage heart;
  int totalLives;
  float heartL = 460, heartT = 0, heartW = 40, heartH = 33;    // dimensions for heart 

  // Constructor
  Lives(int lives, String h) {
    totalLives = lives;
    heart = loadImage(h);
  }
  
  /** Display number of hearts based on current amount of lives */
  void displayHearts(int numOfLives) {
    if (numOfLives == 0)  return;                            //displays nothing if zero lives

    if (numOfLives == 3) {
      image(heart, heartL, heartT, heartW, heartH);    
      image(heart, heartL-30, heartT, heartW, heartH);
      image(heart, heartL-60, heartT, heartW, heartH);
    }
    if (numOfLives == 2) {
      image(heart, heartL, heartT, heartW, heartH);
      image(heart, heartL-30, heartT, heartW, heartH);
    }

    if (numOfLives == 1) 
      image(heart, heartL, heartT, heartW, heartH);
    
  }


   /** Lives decrease by 1 when user loses*/
  int decreaseLife(int numOfLives) {
    
    if (numOfLives == 3)   return totalLives = 2;         //if 3 lives, decrease to 2
    if (numOfLives == 2)   return totalLives = 1 ;        //if 2 lives, decrease to 1
    if (numOfLives == 1)   return totalLives = 0;         //if 1 life, decrease to 0
    return totalLives = 0;                                //if zero lives
  }

  /** Gets the current score */
  int getCurrentLives(){
    return totalLives;
  }
  
  
}
