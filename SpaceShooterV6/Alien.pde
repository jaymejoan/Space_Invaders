/*Alien class */
public class Alien {
  //array of alien positions

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

  float left, top, alienWidth, alienHeight, leftPos = 300, rightPos = 300;               //dimensions of each alien
  float shootAt; //time when alien shoots bullet
  int alienIndex; //randomly selected alien  
  ArrayList<Alien> aliens = new ArrayList<Alien>();       //array list of aliens

  //images of each alien
  PImage purpleAlien = loadImage("alien.png"), 
    blueAlien = loadImage("blueAlien.png"), 
    yellowAlien = loadImage("yellowAlien2a.png"), 
    greenAlien = loadImage("greenAlien.png"), 
    redAlien = loadImage("redAlien3.png"), 
    skyBlueAlien = loadImage("skyblueAlien.png"), 
    bossAlien = loadImage("orangeAlien.png"), 
    alienObject;

  // Constructor 
  Alien(float w, float h) {
    //100, 50
    alienWidth = w;
    alienHeight = h;
  }

  /** Displays the aliens on screen */
  void displayAliens(float[][] alienPos) {
    alienPositions = alienPos;
    //draws purple aliens
    for (int i=0; i<alienPos.length-10; i++)
      //for (int i=0; i<alienPos.length-10; i++)
      if (alienPos[i]!=null) {
        image(purpleAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight);
        //image(purpleAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight);
        //println("purple: " + alienHeight);
        fill(0, 0, 255);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);            //left
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5); //right
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }

    //draws skyBlue aliens
    for (int i=5; i<alienPositions.length-5; i++) 
      //for (int i=5; i<alienPos.length-5; i++) 
      if (alienPos[i]!=null) {
        image(greenAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+25);
        //println("blue: " + (alienHeight+25));
        fill(0, 255, 0);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }  

    //draws yellow aliens
    for (int i=10; i<alienPositions.length; i++) 
      //for (int i=10; i<alienPos.length; i++) 
      if (alienPos[i]!=null) {
        image(skyBlueAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+10);
        //println("yellow: " + (alienHeight+50));
        fill(255, 0, 0);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }
  }

  void displayAliens2(float[][]alienPos) {
    alienPositions2 = alienPos;
    //draws purple aliens
    //for (int i=0; i<alienPositions.length-10; i++)
    for (int i=0; i<alienPos.length-20; i++)
      if (alienPos[i]!=null) {
        //image(purpleAlien, alienPositions[i][0], alienPositions[i][1], alienWidth, alienHeight);
        image(purpleAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight);
        //println("purple: " + alienHeight);
        fill(0, 0, 255);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);            //left
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5); //right
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }

    //draws red aliens
    //for (int i=5; i<alienPositions.length-5; i++) 
    for (int i=5; i<alienPos.length-15; i++) 
      if (alienPos[i]!=null) {
        image(redAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+25);
        //println("blue: " + (alienHeight+25));
        fill(0, 255, 0);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }  

    //draws yellow aliens
    //for (int i=10; i<alienPositions.length; i++) 
    for (int i=10; i<alienPos.length-10; i++) 
      if (alienPos[i]!=null) {
        image(yellowAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+10);
        //println("yellow: " + (alienHeight+50));
        fill(255, 0, 0);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }

    //draws green aliens
    for (int i=15; i<alienPos.length-5; i++) 
      if (alienPos[i]!=null) {
        image(greenAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+25);
        //println("yellow: " + (alienHeight+50));
        fill(255, 0, 0);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }


    //draws sky blue aliens
    for (int i=20; i<alienPos.length; i++) 
      if (alienPos[i]!=null) {
        image(skyBlueAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+10);
        //println("yellow: " + (alienHeight+50));
        fill(255, 0, 0);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }
  }

  void displayAliens3(float[][]alienPos) {
    //draws purple aliens
    //for (int i=0; i<alienPositions.length-10; i++)
    for (int i=0; i<alienPos.length-20; i++)
      if (alienPos[i]!=null) {
        //image(purpleAlien, alienPositions[i][0], alienPositions[i][1], alienWidth, alienHeight);
        image(purpleAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight);
        //println("purple: " + alienHeight);
        fill(0, 0, 255);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);            //left
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5); //right
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }

    //draws red aliens
    //for (int i=5; i<alienPositions.length-5; i++) 
    for (int i=5; i<alienPos.length-15; i++) 
      if (alienPos[i]!=null) {
        image(redAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+25);
        //println("blue: " + (alienHeight+25));
        fill(0, 255, 0);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }  

    //draws yellow aliens
    //for (int i=10; i<alienPositions.length; i++) 
    for (int i=10; i<alienPos.length-10; i++) 
      if (alienPos[i]!=null) {
        image(yellowAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+10);
        //println("yellow: " + (alienHeight+50));
        fill(255, 0, 0);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }

    //draws green aliens
    for (int i=15; i<alienPos.length-5; i++) 
      if (alienPos[i]!=null) {
        image(greenAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+25);
        //println("yellow: " + (alienHeight+50));
        fill(255, 0, 0);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }


    //draws sky blue aliens
    for (int i=20; i<alienPos.length; i++) 
      if (alienPos[i]!=null) {
        image(skyBlueAlien, alienPos[i][0], alienPos[i][1], alienWidth, alienHeight+10);
        //println("yellow: " + (alienHeight+50));
        fill(255, 0, 0);
        //rect(alienPositions[i][0], alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1], 5, 5);
        //rect(alienPositions[i][0]+alienWidth, alienPositions[i][1]+alienHeight, 5, 5); //top
      }
  }

  //loads aliens into array list 
  void loadAliens() {
    for (int i=0; i<alienPositions.length; i++) {
      aliens.add(new Alien(alienPositions[i][0], alienPositions[i][1]));
    }
  }


  //returns 2D array of aliens position (Level 1)
  float[][] getLevel1Aliens() {
    return alienPositions;
  }

  //returns 2D array of aliens position (Level 2)
  float[][] getLevel2Aliens() {
    return alienPositions2;
  }

  //returns 2D array of aliens position (Level 3)
  float[][] getLevel3Aliens() {
    return alienPositions3;
  }


  //moves aliens right
  //void moveRight() {
  //  for (int i=0; i<alienPositions.length; i++) 
  //    if (alienPositions[i]!=null) 
  //      alienPositions[i][0] +=2;
  void moveRight(float[][] alienPos) {
    for (int i=0; i<alienPos.length; i++) 
      if (alienPos[i]!=null) 
        alienPos[i][0] +=2;
  }

  //max LHS: left = -2.0, right = 93
  //max RHS: left = 502, right = 597



  // resets to max right position
  //if (leftPos >= 502 || rightPos >= 597) {
  //  leftPos = 502;
  //  rightPos = 597;
  //}

  //rightPos+=2;
  //leftPos-=2;

  //if (leftPos <= -2.0 || rightPos >= 93) {
  //  leftPos = 0.0;
  //  rightPos = 93;
  //}


  //moves aliens left
  void moveLeft(float[][] alienPos) {
    for (int i=0; i<alienPos.length; i++)
      if (alienPos[i]!=null) 
        alienPos[i][0]-=2;
  }


  // if (leftPos >= 502 || rightPos <= 597) {
  //  leftPos = 502;
  //  rightPos = 597;
  //}



  //if (leftPos <= -2.0 || rightPos <= 93) {
  //  leftPos = 0.0;
  //  rightPos = 93;
  //}

  //leftPos+=2;
  //rightPos-=2;

  //moves aliens down
  void moveDown(float[][] alienPos) {
    for (int i=0; i<alienPos.length; i++)
      if (alienPos[i]!=null)
        alienPos[i][1] += 2;
  }

  /** checks if alien is touching the ground */
  boolean isTouchingGround(float[][] alienPos) {
    for (int i=0; i<alienPos.length; i++) {
      //println("index: " + i);
      if (alienPos[i]!=null)
        if (alienPos[i][1]+alienHeight >= 800) {
          //println("index: " + i);
          //println("touching ground");
          return true;
        }
    }
    return false;
  }

  /** checks if alien is touching the spaceship */
  boolean isTouchingShip(float[][] alienPos, float spaceHeight, float spaceLeft, float spaceRight) {
    for (int i=0; i<alienPos.length; i++) 
      if (alienPos[i] != null) 
        if ((alienPos[i][1]+alienHeight >= spaceHeight) && (alienPos[i][0]>=spaceLeft && alienPos[i][0]<=spaceRight))
          return true;


    return false;
  }


  void shootBullets(float min, float max, float[][] alienPos, int count, Bullet bullet, Alien alien) {
    shootAt = (int)random(min, max);              //when the bullet is shot
    alienIndex = (int) random(1, alienPos.length-1);       //which alien the bullet is shot from
    //for (int i=0; i<alienPos.length; i++) {
    //if (count >= shootAt) {  
    //  if(alienPos[alienIndex][0] != null){
    //  bullet.displayAlienBullet(alienPos, alienIndex, alien);
    //  bullet.moveAlienBullet();
    //  }
    //}
  }


  // removes position
  //void removePosition(float alienPos, int i){

  //}
  //boolean isTouching(int i, float spaceHeight, float spaceLeft, float spaceRight) {
  //  if ((alienPositions[i][1] >= spaceHeight) && (alienPositions[i][0] >= spaceLeft && alienPositions[i][0] <= spaceRight))
  //    return true;

  //  return false;
  //}

  ///** Clears the entire array of aliens 
  // * called when user's lives reaches zero during a game */
  //void clearPositions(float[][] alienPos) {
  //  for (int i=0; i<=alienPos.length; i++)
  //    if (alienPos[i] != null)
  //      alienPos[i] = null;
  //}

  //gets left side of alien
  float getLeftSide(float[][] alienPos, int index) {
    if (alienPos[index]!=null) 
      return(alienPos[index][0]);
    return 0.0;
  }

  //gets right side (width) of alien
  float getRightSide(float[][] alienPos, int index) {
    if (alienPos[index]!=null)
      return(alienPos[index][0]+alienWidth);
    return 0.0;
  }

  //gets bottom of alien
  float getBottom(float[][] alienPos, int index) {
    if (alienPos[index]!=null) {
      fill(255);
      rect(alienPos[index][0], alienPos[index][1]+alienHeight, 5, 5);
      //println("index: " +  index + " " + (alienPositions[index][1]+alienHeight));
      return(alienPos[index][1]+alienHeight);
    }
    return 0.0;
  }

  float getCentre(float[][] alienPos, int index) {
    if (alienPos[index]!=null) {
      fill(255);
      rect((alienPos[index][0]+alienWidth)/2, alienPos[index][1]+alienHeight, 5, 5);
      //println("index: " +  index + " " + (alienPositions[index][1]+alienHeight));
      return((alienPos[index][0]+alienWidth)/2);
    }
    return 0.0;
  }

  float getLeftPos() {
    return leftPos;
  }

  float getRightPos() {
    return rightPos;
  }
}
