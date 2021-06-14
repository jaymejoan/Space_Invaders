/** Main class */
//PImage gameOver, youWin, title;

// Spaceship 
Spaceship spaceship; //spaceship object


// Alien
Alien alien;                                                      //alien object
float[][] alienPositions, alienPositions2, alienPositions3;       //2D array of aliens' positions
float alienLeft, alienRight, alienBottom;                         //dimensions of alien
int currentAlien;                                                 //index of alien to be removed 


//Bullet
Bullet bullet, currentBullet;                          //bullet objects
ArrayList<Bullet> bullets = new ArrayList<Bullet>();   //array list of bullets
float bulletW = 10, bulletH = 20, bulletSpeed = 10;    //dimensions of bullet
boolean shooting = false;                              //user has not shot bullet

//Levels
mainMenu mainMenu;                                     //main menu
Level1 level1;                                         //Level one (core)
Level2 level2;                                         //Level two (completion)
Level3 level3;                                         //Level three (challenge)


float speed = 9.0;                                     //speed of the spaceship
float vx = speed;                                      //horizontal speed of the spaceship
int time;                                              //number of time draw has been called since starting the program
boolean hasWon = false, userLost = false;              //user has not won the game

//ArrayList<Alien> aliens; //array list of aliens

int levelNum;                                           //number of current level (starts at main menu)
int numOfLives;                                         //number of lives left 

//image names
String background = "background.png", title = "title.png", selectLevel = "selectLevel.png", 
  l1 = "Level1.png", l2 = "Level2.png", l3 = "Level3.png", neonBox = "neonBox.png", 
  score = "score.png", lives = "lives.png", heart = "heart.png", continueSign = "continue.png", menu = "menu.png", 
  youWin = "youWin.png", youLose = "youLose.png", gameOver = "gameOver.png", tryAgain = "tryAgain.png";

void setup() {
  size(600, 800);
  //background = loadImage("background.png");
  //gameOver = loadImage("gameOver.png");
  //youWin = loadImage("youWin.png");

  // Constructs spaceship
  spaceship = new Spaceship("spaceship1.png", 250, 700, 100, 70);

  // Constructs alien
  alien = new Alien(100, 50);
  //alien = new Alien(90, 50);
  alienPositions = alien.getLevel1Aliens();            //gets array of alien positions in level 1
  alienPositions2 = alien.getLevel2Aliens();           //gets array of alien positions in level 2
  alienPositions3 = alien.getLevel3Aliens();           //gets array of alien positions in level 3

  // Constructs levels
  // main menu
  //mainMenu = new mainMenu("title.png", "background.png", "selectLevel.png", 
  //  "neonBox.png", "Level1.png", "Level2.png", "Level3.png");
  mainMenu = new mainMenu(title, background, selectLevel, neonBox, l1, l2, l3);

  // level 1
  level1 = new Level1(1, background, youWin, youLose, gameOver, continueSign, menu, neonBox, score, lives, heart, l1, alien, alienPositions);
  //level1 = new Level1(1, "background.png", "youWin.png", "gameOver.png", 
  //  "continue.png", "menu.png", "neonBox.png", "score.png", "lives.png", "heart.png", "Level1.png", alien, alienPositions);


  //level 2
  level2 = new Level2(2, background, youWin, gameOver, continueSign, menu, neonBox, l2, score, lives, alien, alienPositions2);
  //level2 = new Level2(2, "background.png", "youWin.png", "gameOver.png", 
  //  "continue.png", "menu.png", "neonBox.png", "Level2.png", "score.png", "lives.png", alien, alienPositions2);

  //level3 
  level3 = new Level3(3, background, youWin, gameOver, continueSign, menu, neonBox, l3, score, lives, alien, alienPositions3);
  //level3 = new Level3(3, "background.png", "youWin.png", "gameOver.png", 
  //  "continue.png", "menu.png", "neonBox.png", "Level3.png", "score.png", "lives.png", alien, alienPositions3);

  //initialisation
  levelNum = 0;
  numOfLives = 3;
}

void draw() {
  background(0);

  switch(levelNum) {
    // main menu
  case 0: 
    mainMenu.redraw(numOfLives);                  // runs main menu
    levelNum = mainMenu.getLevel();               // gets the starting level selected by user
    numOfLives = mainMenu.getNumOfLives();        // resets lives to three
    time = 0;    
    break;

    // level 1
  case 1:
    level1.redraw(time, numOfLives);               // runs first level
    levelNum = level1.getNextLevel();              // gets next level
    numOfLives = level1.getNumOfLives();           //  gets current num of lives left
    time = level1.resetTime();                     // resets starting time (only if changing levels)

    break;

    //level 2
  case 2:
    level2.redraw(time, numOfLives);
    levelNum = level2.getNextLevel(); 
    time = level2.resetTime();
    break; 

    //level 3
  case 3:
    level3.redraw(time, numOfLives);
    levelNum = level3.getNextLevel(); 
    time = level3.resetTime();
  }


  time++;

  //resets counter so aliens continue to move down
  if (time>83)
    time = 0;
}
