SpaceShip myShip;

int numOfEnemies = 20;
SpaceShip[] enemy = new SpaceShip[numOfEnemies];

int numOfMaxShots = 50;
Shot[] shots = new Shot[numOfMaxShots];
int nextShot = 0;

int numOfMaxBombs = 100;
Bomb[] bombs = new Bomb[numOfMaxBombs];
int nextBomb = 0;
boolean keyLeft = false;
boolean keyRight = false;
boolean keyUp = false;
boolean keyDown = false;

void setup() {
  size(displayWidth, displayHeight, P2D);
  pixelDensity(displayDensity());
  background(255);
  fill(0, 0, 0);
  noStroke();
  frameRate(60);
  myShip = new SpaceShip(loadImage("test01.png"), width/2, (height * 3) / 4, 3, 1);
  myShip.visible = true;
  for(int i = 0; i < numOfEnemies; i++) {
    float spawnX = random(0, width);
    float spawnY = random(0, height/4);
    enemy[i] = new SpaceShip(loadImage("enemy_reiwa.png"), int(spawnX), int(spawnY), 3, 2);
    enemy[i].visible = true;
  }
  for(int i = 0; i < numOfMaxShots; i++) {
    shots[i] = new Shot(0, height + 100, color(255, 0, 255));
  }
  for(int i = 0; i < numOfMaxBombs; i++) {
    bombs[i] = new Bomb(0, -100, color(255, 0, 0));
  }
}

void draw() {
  background(255);
  myShip.draw();
  myShipController();
  drawEnemies();
  drawBombs();
  enemyController();
  shotsController();
  collisionDetection();
}

void drawEnemies() {
  for(int i = 0; i < numOfEnemies; i++) {
    enemy[i].draw();
  }
}

void enemyController() {
  for(int i = 0; i < numOfEnemies; i++) {
    if(enemy[i].xpos < 0 || enemy[i].xpos + enemy[i].getWidth() > width) {
      enemy[i].speed = - enemy[i].speed;
    }
    enemy[i].moveXaxis();
    if(enemy[i].visible) {
      if(floor(random(50)) == 5) {
        bombs[nextBomb].xpos = enemy[i].xpos + enemy[i].getWidth() / 2;
        bombs[nextBomb].ypos = enemy[i].ypos + enemy[i].getHeight();
        bombs[nextBomb].visible = true;
        nextBomb = (nextBomb + 1) % numOfMaxBombs;
      }
    }
  }
}

void drawBombs() {
  for(int i = 0; i < numOfMaxBombs; i++) {
    bombs[i].draw();
    bombs[i].move();
  }
}

void collisionDetection() {
  for(int i = 0; i < numOfEnemies; i++) {
    for(int j = 0; j < numOfMaxShots; j++) {
      if(enemy[i].visible && enemy[i].isIn(shots[j].xpos, shots[j].ypos)) {
        enemy[i].visible = false;
        shots[j].visible = false;
      }
    }
  }
  for(int i = 0; i < numOfMaxBombs; i++) {
    if(bombs[i].visible && myShip.isIn(bombs[i].xpos, bombs[i].ypos)) {
      myShip.visible = false;
    }
  }
}

void keyPressed() {
  if(key == 'd') {
    keyRight = true;
  }
  if(key == 'a') {
    keyLeft = true;
  }
  if(key == 'w') {
    keyUp = true;
  }
  if(key == 's') {
    keyDown = true;
  }
}

void keyReleased() {
  if(key == 'a') {
    keyLeft = false;
  }
  else if(key == 'd') {
    keyRight = false;
  }
  else if(key == 'w') {
    keyUp = false;
  }
  else if(key == 's') {
    keyDown = false;
  }
  else if(keyCode == ' ') {
    fire();
  }
}

void myShipController() {
  if(keyLeft) {
    myShip.speed = - abs(myShip.speed);
    if(myShip.xpos + myShip.speed >= 0) {
      myShip.moveXaxis();
    }
  }
  else if(keyRight) {
    myShip.speed = abs(myShip.speed);
    if(myShip.xpos + myShip.getWidth() + myShip.speed <= width) {
      myShip.moveXaxis();
    }
  }
  else if(keyUp) {
    myShip.speed = - abs(myShip.speed);
    if(myShip.ypos + myShip.speed >= 0) {
      myShip.moveYaxis();
    }
  }
  else if(keyDown) {
    myShip.speed = abs(myShip.speed);
    if(myShip.ypos + myShip.getHeight() + myShip.speed <= height) {
      myShip.moveYaxis();
    }
  }
}

void shotsController() {
  for(int i = 0; i < numOfMaxShots; i++) {
    shots[i].draw();
    shots[i].move();
  }
}

void fire() {
  if(myShip.visible) {
    shots[nextShot].xpos = myShip.xpos + myShip.getWidth() / 2;
    shots[nextShot].ypos = myShip.ypos;
    shots[nextShot].visible = true;
    nextShot = (nextShot + 1) % numOfMaxShots;
  }
}

class SpaceShip {
  PImage img;
  int xpos;
  int ypos;
  int speed;
  int scale;
  boolean visible = false;

  SpaceShip(PImage _img, int _xpos, int _ypos, int _speed, int _scale) {
    img = _img;
    xpos = _xpos;
    ypos = _ypos;
    speed = _speed;
    scale = _scale;
  }

  void draw() {
    if(visible) {
      image(img, xpos, ypos, getWidth(), getHeight());
    }
  }

  void moveXaxis() {
    xpos += speed;
  }

  void moveYaxis() {
    ypos += speed;
  }

  int getWidth() {
    return img.width / scale;
  }

  int getHeight() {
    return img.height / scale;
  }

  boolean isIn(int x, int y) {
    if(x >= xpos && x <= xpos + getWidth() &&
       y >= ypos && y <= ypos + getHeight()) {
      return true;
    }
    else {
      return false;
    }
  }
}

class Shot {
  int xpos;
  int ypos;
  color c;
  int speed = 8;
  boolean visible = false;

  Shot(int _xpos, int _ypos, color _c) {
    xpos = _xpos;
    ypos = _ypos;
    c = _c;
  }

  void draw() {
    fill(c);
    if(visible) {
      rect(xpos, ypos, 5, 10);
    }
  }

  void move() {
    if(ypos > -50) {
      ypos -= speed;
    }
    else {
      visible = false;
    }
  }
}

class Bomb {
  int xpos;
  int ypos;
  color c;
  int speed = 5;
  boolean visible = false;

  Bomb(int _xpos, int _ypos, color _c) {
    xpos = _xpos;
    ypos = _ypos;
    c = _c;
  }

  void draw() {
    fill(c);
    if(visible) {
      fill(c);
      ellipse(xpos, ypos, 10, 10);
    }
  }

  void move() {
    if(visible && ypos < height + 50) {
      ypos += speed;
    }
    else {
      visible = false;
    }
  }
}