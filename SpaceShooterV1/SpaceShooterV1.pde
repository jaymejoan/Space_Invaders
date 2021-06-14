/** Main class */
PImage background, gameOver, youWin;

// Spaceship 
Spaceship spaceship; //spaceship object
float spaceshipLeft=250, spaceshipTop=500, spaceshipWidth=100, spaceshipHeight=70, spaceshipCentre=50;   //dimensions of spaceship

// Alien
Alien alien; //alien object
float[][] alienPositions; //2D array of aliens' positions
float alienLeft, alienRight, alienBottom; //dimensions of alien
int currentAlien; //index of alien to be removed 


//Bullet
Bullet bullet, currentBullet; //bullet objects
ArrayList<Bullet> bullets = new ArrayList<Bullet>(); //array list of bullets
float bulletW = 10, bulletH = 20, bulletSpeed = 10; //dimensions of bullet
boolean shooting = false; //user has not shot bullet

//Level
Level level; //level number

float speed = 9.0; //speed of the spaceship
float vx = speed; //horizontal speed of the spaceship
int time; //number of time draw has been called since starting the program
boolean hasWon = false, userLost = false; //user has not won the game

//ArrayList<Alien> aliens; //array list of aliens

//int levelNum = 0; //number of current level (starts at main menu)
//String level; // level name

void setup() {
  size(600, 600);
  background = loadImage("background.png");
  gameOver = loadImage("gameOver.png");
  youWin = loadImage("youWin.png");

  //constructs alien
  alien = new Alien(100, 50);
  alienPositions = alien.getArrayOfAliens(); //gets array of alien positions

  //constructs level
  level = new Level(0, background);
}

void draw() {
  background(0);
  level.redraw(time);
  time++;
  if(time>83)
    time = 0;

}
