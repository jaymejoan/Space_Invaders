/** Score class */
public class Score {
  PImage redPowerUp, bluePowerUp;
  int totalScore;
  float redLeft, redTop = 720, redWidth = 50, redHeight = 50, redRight;
  float blueLeft, blueTop = 720, blueWidth = 50, blueHeight = 50, blueRight;

  //Constructor
  Score(int score) {
    totalScore = score;

    //red power up
    redPowerUp = loadImage("redGift.png");
    redLeft = random(30, 580);
    redRight = redLeft+redWidth;
    
    //blue power up
    bluePowerUp = loadImage("blueGift.png");
    blueLeft = random(30, 580);
    blueRight = blueLeft+blueWidth;
  }

  /** adds to total score */
  int addScore(int points) {
    totalScore += points;
    //drawScore();
    return getCurrentScore();
  }

  /** gets the current score */
  int getCurrentScore() {
    return totalScore;
  }

  /** sets the current score */
  void setCurrentScore(int currentScore) {
    totalScore = currentScore;
  }

  /** draws current score */
  void drawScore() {
    text(totalScore, 125, 30);
  }

  //red power up
  /** draws red power up which adds bonus points */
  void displayRedPowerUp() {
    image(redPowerUp, redLeft, redTop, redWidth, redHeight);
  }

  ///** "removes" red power up from screen */
  //void removeRedPowerUp() {
  //    println("remove red");
  //    image(redPowerUp, redLeft, redTop+300, redWidth, redHeight);
    
  //}

  /** returns true if spaceship has hit power up */
  boolean isHittingRedpowerUp(float spaceLeft, float spaceRight) {
    if (redRight>=spaceLeft && redLeft<=spaceRight) {
      println("is Hitting");
      return true;
    }
    return false;
  }

  //blue power up
  /** draws red power up which adds bonus points */
  void displayBluePowerUp() {
    image(bluePowerUp, blueLeft, blueTop, blueWidth, blueHeight);
  }

  ///** "removes" red power up from screen */
  //void removeBluePowerUp() {
  //  println("remove blue");
  //  image(bluePowerUp, blueLeft, blueTop+500, blueWidth, blueHeight);
  //}

  /** returns true if spaceship has hit power up */
  boolean isHittingBluepowerUp(float spaceLeft, float spaceRight) {
    if (blueRight>=spaceLeft && blueLeft<=spaceRight) {
      println("is Hitting");
      return true;
    }
    return false;
  }
}
