/** Main class */
PImage background, gameOver, youWin, title;

// Spaceship 
Spaceship spaceship; //spaceship object


// Alien
Alien alien;                                           //alien object
float[][] alienPositions;                              //2D array of aliens' positions
float alienLeft, alienRight, alienBottom;              //dimensions of alien
int currentAlien;                                      //index of alien to be removed 


//Bullet
Bullet bullet, currentBullet;                          //bullet objects
ArrayList<Bullet> bullets = new ArrayList<Bullet>();   //array list of bullets
float bulletW = 10, bulletH = 20, bulletSpeed = 10;    //dimensions of bullet
boolean shooting = false;                              //user has not shot bullet

//Levels
mainMenu mainMenu;                                     //main menu
Level1 level1;                                         //first level (core)
//Level2 level2;                                       //second level (completion)

float speed = 9.0;                                     //speed of the spaceship
float vx = speed;                                      //horizontal speed of the spaceship
int time;                                              //number of time draw has been called since starting the program
boolean hasWon = false, userLost = false;              //user has not won the game

//ArrayList<Alien> aliens; //array list of aliens

int levelNum; //number of current level (starts at main menu)

//String level; // level name

void setup() {
  size(600, 800);
  //background = loadImage("background.png");
  gameOver = loadImage("gameOver.png");
  //youWin = loadImage("youWin.png");

  // Constructs spaceship
  spaceship = new Spaceship("spaceship1.png", 250, 700, 100, 70);
  
  // Constructs alien
  alien = new Alien(100, 50);
  alienPositions = alien.getArrayOfAliens(); //gets array of alien positions


  // Constructs levels
  mainMenu = new mainMenu("title.png", "background.png", "selectLevel.png", 
                          "neonBox.png", "Level1.png", "Level2.png", "Level3.png");
  level1 = new Level1(0, "background.png", "youWin.png", "gameOver.png", alien, alienPositions);
  levelNum = 0;
}

void draw() {
  background(0);

  switch(levelNum) {
  // main menu
  case 0: 
    mainMenu.redraw();
    levelNum = mainMenu.getLevel(); // gets the starting level selected by user
    time = 0;
    break;
    
  // level 1
  case 1:
    //println("Level1");
    //level1.redraw(time, spaceship);
    level1.redraw(time);
    //level1.keyPressed();
    //spaceship.getNewPos(); //gets updated position of spaceship
    
    //spaceship = spaceship.getNewPos(); //gets updated position of spaceship
    break;
    
  //level 2
  // case 2:
  //  level2.redraw(time);
  
  //level 3
  // case 3:
  //  level3.redraw(time);
  }



  time++;

  //resets counter so aliens continue to move down
  if (time>83)
    time = 0;
}
