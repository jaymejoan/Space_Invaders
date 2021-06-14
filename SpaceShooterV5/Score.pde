/** Score class */
public class Score {

  int totalScore;
  
  //Constructor
  Score(int score) {
    totalScore = score;
  }
  
  /** adds to total score */
  int addScore(int points){
    totalScore += points;
    //drawScore();
    return getCurrentScore();
  }
  
  /** gets the current score */
  int getCurrentScore(){
    return totalScore;
  }
  
  /** sets the current score */
  void setCurrentScore(int currentScore){
    totalScore = currentScore;
  }
  
  /** draws current score */
  void drawScore(){
    println("draw score");
    text(totalScore, 125, 30);
  }
}
