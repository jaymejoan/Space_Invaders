/*Alien class */
public class Alien {
  // Positions of level 1 aliens
  float[][] alienPositions = {{0, 25}, {110, 25}, {220, 25}, {330, 25}, {440, 25}, 
    {0, 95}, {110, 95}, {220, 95}, {330, 95}, {440, 95}, 
    {0, 165}, {110, 165}, {220, 165}, {330, 165}, {440, 165}}; 

  // Positions of level 2 aliens
  float[][] alienPositions2 = {{0, 25}, {110, 25}, {220, 25}, {330, 25}, {440, 25}, 
    {0, 95}, {110, 95}, {220, 95}, {330, 95}, {440, 95}, 
    {0, 165}, {110, 165}, {220, 165}, {330, 165}, {440, 165}, 
    {0, 235}, {110, 235}, {220, 235}, {330, 235}, {440, 235}, 
    {0, 305}, {110, 305}, {220, 305}, {330, 305}, {440, 305}}; 

  // Positions of level 3 aliens
  float[][] alienPositions3 = {{0, 25}, {110, 25}, {220, 25}, {330, 25}, {440, 25}, 
    {0, 95}, {110, 95}, {220, 95}, {330, 95}, {440, 95}, 
    {0, 165}, {110, 165}, {220, 165}, {330, 165}, {440, 165}, 
    {0, 235}, {110, 235}, {220, 235}, {330, 235}, {440, 235}, 
    {0, 305}, {110, 305}, {220, 305}, {330, 305}, {440, 305}}; 

  float left, top, alienWidth, alienHeight, leftPos = 300, rightPos = 300, speed;               // dimensions of each alien

  //Images of each alien
  PImage purpleAlien = loadImage("alien.png"), 
    blueAlien = loadImage("blueAlien.png"), 
    yellowAlien = loadImage("yellowAlien2a.png"), 
    greenAlien = loadImage("greenAlien.png"), 
    redAlien = loadImage("redAlien3.png"), 
    skyBlueAlien = loadImage("skyblueAlien.png"), 
    bossAlien = loadImage("orangeAlien.png");

  // Constructor 
  Alien(float w, float h) {
    alienWidth = w;
    alienHeight = h;
  }

  /** Displays the aliens on screen  (Level 1) */
  void displayAliens(float[][] alienPos) {
    alienPositions = alienPos;
    // draws purple aliens
    for (int i=0; i<alienPos.length-10; i++)
      if (alienPos[i]!=null) 
        image(purpleAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight);

    // draws skyBlue aliens
    for (int i=5; i<alienPositions.length-5; i++) 
      if (alienPos[i]!=null) 
        image(greenAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+25);


    // draws yellow aliens
    for (int i=10; i<alienPositions.length; i++)  
      if (alienPos[i]!=null) 
        image(skyBlueAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+10);
  }

  /** Displays the aliens on screen  (Level2 and 3) */
  void displayAliens2(float[][]alienPos) {
    alienPositions2 = alienPos;
    // draws purple aliens
    for (int i=0; i<alienPos.length-20; i++)
      if (alienPos[i]!=null) 
        image(purpleAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight);

    // draws red aliens
    for (int i=5; i<alienPos.length-15; i++) 
      if (alienPos[i]!=null) 
        image(redAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+25);


    // draws yellow aliens
    for (int i=10; i<alienPos.length-10; i++) 
      if (alienPos[i]!=null) 
        image(yellowAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+10);

    // draws green aliens
    for (int i=15; i<alienPos.length-5; i++) 
      if (alienPos[i]!=null) 
        image(greenAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+25);



    // draws sky blue aliens
    for (int i=20; i<alienPos.length; i++) 
      if (alienPos[i]!=null) 
        image(skyBlueAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+10);
  }

  /** Moves aliens right */
  void moveRight(float[][] alienPos, int speed) {
    for (int i=0; i<alienPos.length; i++) 
      if (alienPos[i]!=null) 
        alienPos[i][0] += speed;
  }

  /** Moves aliens left */
  void moveLeft(float[][] alienPos, int speed) {
    for (int i=0; i<alienPos.length; i++)
      if (alienPos[i]!=null) 
        alienPos[i][0] -= speed;
  }

  /** Moves aliens down */
  void moveDown(float[][] alienPos, int speed) {
    for (int i=0; i<alienPos.length; i++)
      if (alienPos[i]!=null)
        alienPos[i][1] += speed;
  }

  /** Checks if alien is touching the ground */
  boolean isTouchingGround(float[][] alienPos) {
    for (int i=0; i<alienPos.length; i++) 
      if (alienPos[i]!=null)
        if (alienPos[i][1]+alienHeight >= 800) 
          return true;

    return false;
  }

  /** Checks if alien is touching the spaceship */
  boolean isTouchingShip(float[][] alienPos, float spaceHeight, float spaceLeft, float spaceRight) {
    for (int i=0; i<alienPos.length; i++) 
      if (alienPos[i] != null) 
        if ((alienPos[i][1]+alienHeight >= spaceHeight) && (alienPos[i][0]>=spaceLeft && alienPos[i][0]<=spaceRight))
          return true;

    return false;
  }

  /** Returns 2D array of aliens position (Level 1) */
  float[][] getLevel1Aliens() {
    return alienPositions;
  }

  /** Returns 2D array of aliens position (Level 2) */
  float[][] getLevel2Aliens() {
    return alienPositions2;
  }

  /** Returns 2D array of aliens position (Level 3) */
  float[][] getLevel3Aliens() {
    return alienPositions3;
  }

  /** Returns original copy of level 1 positions */
  float[][] getOriginalLevel1Aliens() {
    float[][] originalLevel1 = {{0, 25}, {110, 25}, {220, 25}, {330, 25}, {440, 25}, 
      {0, 95}, {110, 95}, {220, 95}, {330, 95}, {440, 95}, 
      {0, 165}, {110, 165}, {220, 165}, {330, 165}, {440, 165}}; 

    alienPositions = originalLevel1;
    return originalLevel1;
  }

  /** Returns original copy of level 2 and 3 positions */
  float[][] getOriginalLevel2Aliens() {
    float[][] originalLevel2 = {{0, 25}, {110, 25}, {220, 25}, {330, 25}, {440, 25}, 
      {0, 95}, {110, 95}, {220, 95}, {330, 95}, {440, 95}, 
      {0, 165}, {110, 165}, {220, 165}, {330, 165}, {440, 165}, 
      {0, 235}, {110, 235}, {220, 235}, {330, 235}, {440, 235}, 
      {0, 305}, {110, 305}, {220, 305}, {330, 305}, {440, 305}}; 

    alienPositions2 = originalLevel2;
    alienPositions3 = originalLevel2;
    return originalLevel2;
  }

  /** Gets left side of alien */
  float getLeftSide(float[][] alienPos, int index) {
    if (alienPos[index]!=null) 
      return(alienPos[index][0]);
    return 0.0;
  }

  /** Gets right side (width) of alien */
  float getRightSide(float[][] alienPos, int index) {
    if (alienPos[index]!=null)
      return(alienPos[index][0]+alienWidth);
    return 0.0;
  }

  /** Gets bottom of alien */
  float getBottom(float[][] alienPos, int index) {
    if (alienPos[index]!=null) 
      return(alienPos[index][1]+alienHeight);

    return 0.0;
  }

  /** Gets left position of alien */
  float getLeftPos() {
    return leftPos;
  }

  /** Gets right position of alien */
  float getRightPos() {
    return rightPos;
  }
}
