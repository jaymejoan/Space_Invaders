/** Score class */
public class Score {
  PImage redPowerUp, bluePowerUp;
  int totalScore;
  float redLeft, redTop = 720, redWidth = 50, redHeight = 50, redRight;        // dimensions of red power-up
  float blueLeft, blueTop = 720, blueWidth = 50, blueHeight = 50, blueRight;   // dimensions of blue power-up

  // Constructor 
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

  /** Adds to total score */
  int addScore(int points) {
    totalScore += points;
    return getCurrentScore();
  }

  /** Gets the current score */
  int getCurrentScore() {
    return totalScore;
  }

  /** Sets the current score */
  void setCurrentScore(int currentScore) {
    totalScore = currentScore;
  }

  /** Draws current score */
  void drawScore() {
    text(totalScore, 125, 30);
  }

  /** Displays red power up which adds bonus points */
  void displayRedPowerUp() {
    image(redPowerUp, redLeft, redTop, redWidth, redHeight);
  }

  /** Displays blue power up which adds bonus points */
  void displayBluePowerUp() {
    image(bluePowerUp, blueLeft, blueTop, blueWidth, blueHeight);
  }

  /** Returns true if spaceship has hit power up */
  boolean isHittingRedpowerUp(float spaceLeft, float spaceRight) {
    if (redRight>=spaceLeft && redLeft<=spaceRight) 
      return true;

    return false;
  }

  /** Returns true if spaceship has hit power up */
  boolean isHittingBluepowerUp(float spaceLeft, float spaceRight) {
    if (blueRight>=spaceLeft && blueLeft<=spaceRight) 
      return true;
    return false;
  }
}
