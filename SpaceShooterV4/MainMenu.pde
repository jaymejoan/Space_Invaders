/** Main Menu page */

public class mainMenu {
  PImage titleObject, background, selectLevel, neonBox, level1, level2, level3;
  float tLeft = 35, tTop = 150, tWidth = 590, tHeight = 130;                                  //dimensions of title
  float selectLeft = 140, selectTop = tTop+120, selectWidth = 340, selectHeight = 30;         //dimensions of "selectLevel" sentence
  float level1Left = 200, level1Top = selectTop+70, level1Width = 200, level1Height = 70;     //dimensions of Level 1 box
  float level2Left = 200, level2Top = level1Top+110, level2Width = 200, level2Height = 70;    //dimensions of Level 2 box
  float level3Left = 200, level3Top = level2Top+110, level3Width = 200, level3Height = 70;    //dimensions of Level 3 box
  float neonLeft = 115, neonTop = level1Top-50, neonWidth = 380, neonHeight = 170;            //dimensions of neon box 
  int level, numOfLives;                                                                                  //level number
  //boolean onLevel; //returns true if mouse is on a level box

  /** Constructor */
  mainMenu(String titleName, String bg, String sl, String neonB, String l1, String l2, String l3) {
    titleObject = loadImage(titleName);
    background = loadImage(bg);
    selectLevel = loadImage(sl);
    neonBox = loadImage(neonB);
    level1 = loadImage(l1);
    level2 = loadImage(l2);
    level3 = loadImage(l3);
    
  }

  /** draws interface */
  void redraw(int lives) {
    numOfLives = lives;
    println("main menu reached");
    image(background, 0, 0, 600, 800);
    
    image(titleObject, tLeft, tTop, tWidth, tHeight);
    image(selectLevel, selectLeft, selectTop, selectWidth, selectHeight);
    //image(neonBox, neonLeft, neonTop+110, neonWidth, neonHeight);
    image(level1, level1Left, level1Top, level1Width, level1Height);
    image(level2, level2Left, level2Top, level2Width, level2Height);
    image(level3, level3Left, level3Top, level3Width, level3Height);


    // draws neon box if mouse is hovering over level
    // drawn twice to increase neon effect
    if (mouseOnLevel1()) {
      image(neonBox, neonLeft, neonTop, neonWidth, neonHeight);
      image(neonBox, neonLeft, neonTop, neonWidth, neonHeight);
    }

    if (mouseOnLevel2()) {
      image(neonBox, neonLeft, neonTop+110, neonWidth, neonHeight);
      image(neonBox, neonLeft, neonTop+110, neonWidth, neonHeight);
    }

    if (mouseOnLevel3()) {
      image(neonBox, neonLeft, neonTop+220, neonWidth, neonHeight);
      image(neonBox, neonLeft, neonTop+220, neonWidth, neonHeight);
    }
  }

  /** draws neon box if mouse is on level 1 */
  boolean mouseOnLevel1() {
    if ((mouseX >= level1Left && mouseX <= level1Left+level1Width) 
      && (mouseY >= level1Top && mouseY <= level1Top+level1Height)) {

      //go to level 1 if level 1 box selected
      if (mousePressed == true) 
        level = 1; 

      return true; // mouse is over level 1
    }

    return false;
  }

  /** draws neon box if mouse is on level 3 */
  boolean mouseOnLevel2() {
    if ((mouseX >= level2Left && mouseX <= level2Left+level2Width)
      && (mouseY >= level2Top && mouseY <= level2Top+level2Height)) {

      //go to level 2 if level 2 box selected
      if (mousePressed == true) {
        println("level 2 run");
        level = 2; 
      }
      return true;
    }

    return false;
  }

  /** draws neon box if mouse is on level 3 */
  boolean mouseOnLevel3() {
    if ((mouseX >= level3Left && mouseX <= level3Left+level3Width)
      && (mouseY >= level3Top && mouseY <= level3Top+level3Height)) {

      //go to level 3 if level 3 box selected
      if (mousePressed == true) {
        println("level 3 run");
        level = 3;
      }

      return true;
    }

    return false;
  }

  /** returns the selected level */
  int getLevel() {
    println(level);
    return level; 
  }
  
  /** resets lives back to three */
  int getNumOfLives(){
    return numOfLives = 3;
  }
}
