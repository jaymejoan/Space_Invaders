/*Alien class */
public class Alien {
  //array of alien positions
  //float[][] alienPositions = {{25, 25}, {135, 25}, {245, 25}, {355, 25}, {465, 25}, 
  //  {25, 95}, {135, 95}, {245, 95}, {355, 95}, {465, 95}, 
  //{25, 165}, {135, 165}, {245, 165}, {355, 165}, {465, 165}}; 
  float[][] alienPositions = {{0, 25}, {110, 25}, {220, 25}, {330, 25}, {440, 25}, 
    {0, 95}, {110, 95}, {220, 95}, {330, 95}, {440, 95}, 
    {0, 165}, {110, 165}, {220, 165}, {330, 165}, {440, 165}}; 
    
  ArrayList<Alien> aliens = new ArrayList<Alien>(); //array list of aliens
  
  float left, top, alienWidth, alienHeight; //dimensions of each alien
  
  //images of each alien
  PImage purpleAlien = loadImage("alien.png"), 
    blueAlien = loadImage("blueAlien.png"), 
    yellowAlien = loadImage("yellowAlien.png"),
    alienoObject;

  // Constructor 
  Alien(float w, float h) {
    alienWidth = w;
    alienHeight = h;
  }

  // Displays the aliens on screen 
  void displayAliens() {
    //draws purple aliens
    for (int i=0; i<alienPositions.length-10; i++)
      if (alienPositions[i]!=null)
        image(purpleAlien, alienPositions[i][0], alienPositions[i][1], alienWidth, alienHeight);

    //draws blue aliens
    for (int i=5; i<alienPositions.length-5; i++) 
      if (alienPositions[i]!=null)
        image(blueAlien, alienPositions[i][0], alienPositions[i][1], alienWidth, alienHeight+25);

    //draws yellow aliens
    for (int i=10; i<alienPositions.length; i++) 
      if (alienPositions[i]!=null)
        image(yellowAlien, alienPositions[i][0], alienPositions[i][1], alienWidth+5, alienHeight+50);
  }

  //loads aliens into array list 
  void loadAliens() {
    for (int i=0; i<alienPositions.length; i++) {
      aliens.add(new Alien(alienPositions[i][0], alienPositions[i][1]));
    }
  }

  ////returns array list of aliens
  //ArrayList<Alien> getListOfAliens() {
  //  return aliens;
  //}

  //returns 2D array of aliens position 
  float[][] getArrayOfAliens() {
    return alienPositions;
  }


  //moves aliens right
  void moveRight() {
    for (int i=0; i<alienPositions.length; i++)
      if (alienPositions[i]!=null)
        alienPositions[i][0] +=2;
  }

  //moves aliens left
  void moveLeft() {
    for (int i=0; i<alienPositions.length; i++)
      if (alienPositions[i]!=null)
        alienPositions[i][0]-=2;
  }

  //moves aliens down
  void moveDown() {
    for (int i=0; i<alienPositions.length; i++)
      if (alienPositions[i]!=null)
        alienPositions[i][1] += 2;
  }

  //gets left side of alien
  float getLeftSide(int index) {
    if (alienPositions[index]!=null) 
      return(alienPositions[index][0]);
    return 0.0;
  }

  //gets right side (width) of alien
  float getRightSide(int index) {
    if (alienPositions[index]!=null)
      return(alienPositions[index][0]+alienWidth);
    return 0.0;
  }

  //gets bottom of alien
  float getBottom(int index) {
    if (alienPositions[index]!=null)
      return(alienPositions[index][1]+alienHeight);
    return 0.0;
  }
}
