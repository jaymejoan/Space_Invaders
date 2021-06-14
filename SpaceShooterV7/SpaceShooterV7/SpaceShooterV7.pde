/** Main class */
// Spaceship 
Spaceship spaceship;                                              // spaceship object
float speed = 9.0, vx = speed;                                    // speed of the spaceship

// Alien
Alien alien;                                                      // alien object
bossAlien bossAlien;                                              // boss alien object
float[][] alienPositions, alienPositions2, alienPositions3;       // 2D array of aliens' positions
float alienLeft, alienRight, alienBottom;                         // dimensions of alien
int currentAlien;                                                 // index of alien to be removed 

// Bullet
Bullet bullet, currentBullet;                                     // bullet objects
ArrayList<Bullet> bullets = new ArrayList<Bullet>();              // array list of bullets
float bulletW = 10, bulletH = 20, bulletSpeed = 10;               // dimensions of bullet
boolean shooting = false;                                         // user has not shot bullet

// Levels and score
mainMenu mainMenu;                                                // main menu
Level1 level1;                                                    // Level one (core)
Level2 level2;                                                    // Level two (completion)
Level3 level3;                                                    // Level three (challenge)
Score scoreObject;                                                // score object 

int levelNum, numOfLives, currentScore, count, time;              // number of times draw has been called since starting the program
boolean hasWon = false, userLost = false, runMainMenu = false;    // checks if user has won game or if main menu needs to be run

// image names
String background = "background.png", title = "title.png", selectLevel = "selectLevel.png", 
  l1 = "Level1.png", l2 = "Level2.png", l3 = "Level3.png", neonBox = "neonBox.png", 
  score = "score.png", lives = "lives.png", heart = "heart.png", continueSign = "continue.png", menu = "menu.png", 
  youWin = "youWin.png", youLose = "youLose.png", gameOver = "gameOver.png", tryAgain = "tryAgain.png";

void setup() {
  size(600, 800);
  spaceship = new Spaceship("spaceship1.png", 250, 700, 100, 70);   // Constructs spaceship

  // Constructs aliens and boss alien
  alien = new Alien(100, 50);
  bossAlien = new bossAlien(0, 0, 300, 150);
  alienPositions = alien.getLevel1Aliens();                        //gets array of alien positions in level 1
  alienPositions2 = alien.getLevel2Aliens();                       //gets array of alien positions in level 2
  alienPositions3 = alien.getLevel3Aliens();                       //gets array of alien positions in level 3

  // Initialisation
  levelNum = 0;
  numOfLives = 3;
  scoreObject = new Score(0);
  PFont font = createFont("font.ttf", 32 );                         //sets up font
  textFont(font);

  // Constructs main menu and levels 
  mainMenu = new mainMenu(title, background, selectLevel, neonBox, l1, l2, l3, scoreObject);
  level1 = new Level1(1, background, youWin, youLose, gameOver, continueSign, menu, neonBox, score, lives, heart, l1, alien, alienPositions, scoreObject);
  level2 = new Level2(2, background, youWin, youLose, gameOver, continueSign, menu, neonBox, l2, score, lives, heart, alien, alienPositions2, scoreObject);
  level3 = new Level3(3, background, youWin, youLose, gameOver, continueSign, menu, neonBox, l3, score, lives, heart, alien, alienPositions3, bossAlien, scoreObject);
}

void draw() {
  background(0);

  // Switches between levels
  switch(levelNum) {
    // main menu
  case 0: 
    mainMenu.redraw(numOfLives, runMainMenu);                       // runs main menu
    runMainMenu = mainMenu.checkRunMainMenu();                      //returns true after user has completed a level 

    if (runMainMenu || count == 1) {                                // resets levels once
      resetLevels();
      count = 0;
    }

    levelNum = mainMenu.getLevel();                                 // gets the starting level selected by user
    numOfLives = mainMenu.getNumOfLives();                          // resets lives to three
    time = 0;    
    break;

    // Level 1
  case 1:
    level1.redraw(time, numOfLives);                                // runs first level
    runMainMenu = level1.checkRunMainMenu();                        //returns true if level is completed and main menu selected

    if (runMainMenu == true) count = 1;                             //ensures levels are only reset once;
    else  count = 0;

    levelNum = level1.getNextLevel();                               // gets next level
    numOfLives = level1.getNumOfLives();                            // gets current number of lives 
    time = level1.resetTime();                                      // resets starting time 
    break;

    // Level 2
  case 2:
    level2.redraw(time, numOfLives);
    runMainMenu = level2.checkRunMainMenu();       


    if (runMainMenu == true) count = 1;
    else  count = 0;

    levelNum = level2.getNextLevel(); 
    numOfLives = level2.getNumOfLives();
    time = level2.resetTime();
    break; 

    // Level 3
  case 3:
    level3.redraw(time, numOfLives);
    runMainMenu = level3.checkRunMainMenu();                         

    if (runMainMenu == true) count = 1;
    else  count = 0;

    levelNum = level3.getNextLevel(); 
    numOfLives = level3.getNumOfLives();
    time = level3.resetTime();
    break;
  }

  time++;

  // resets counter so aliens continue to move down
  if (time>83)
    time = 0;
}

/** Resets all levels */
void resetLevels() {
  spaceship = new Spaceship("spaceship1.png", 250, 700, 100, 70);      // Re-constructs spaceship

  // Re-constructs aliens and boss alien
  alien = new Alien(100, 50);
  bossAlien = new bossAlien(0, 0, 300, 150);
  alienPositions = alien.getOriginalLevel1Aliens();                    //gets original array of alien positions in level 1
  alienPositions2 = alien.getOriginalLevel2Aliens();                   //gets original array of alien positions in level 2
  alienPositions3 = alien.getOriginalLevel2Aliens();                   //gets original array of alien positions in level 3

  // Re-initialisation
  levelNum = 0;
  numOfLives = 3;
  scoreObject = new Score(0);

  // Resets main menu and levels
  mainMenu = new mainMenu(title, background, selectLevel, neonBox, l1, l2, l3, scoreObject);
  level1 = new Level1(1, background, youWin, youLose, gameOver, continueSign, menu, neonBox, score, lives, heart, l1, alien, alienPositions, scoreObject);
  level2 = new Level2(2, background, youWin, youLose, gameOver, continueSign, menu, neonBox, l2, score, lives, heart, alien, alienPositions2, scoreObject);
  level3 = new Level3(3, background, youWin, youLose, gameOver, continueSign, menu, neonBox, l3, score, lives, heart, alien, alienPositions3, bossAlien, scoreObject);
}
