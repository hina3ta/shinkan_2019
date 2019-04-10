ArrayList<Bullet> bulletList;
ArrayList<Laser> laserList;
Enemy enemy;
Player player;

void mouseClicked() {
  setup();
}

void setup() {
  size(500, 500);
  pixelDensity(displayDensity());
  background(255, 255, 255);
  fill(0);
  noStroke();
  frameRate(60);
  
  bulletList = new ArrayList<Bullet>();
  laserList = new ArrayList<Laser> ();
  enemy = new Enemy();
  player = new Player(loadImage("test01.png"), float(width/2), float((height * 3) / 4), 1);
}

void draw() {
  fill(255);
  rect(0, 0, width, height);

  fill(255, 0, 0);
  for (int i = bulletList.size()-1; i >= 0; i--) {
    Bullet bullet = bulletList.get(i);
    bullet.move();
    bullet.draw();
    if (collision(player.x, player.y, 5, 5, bullet.x, bullet.y, 5, 5)) {
      bullet.hit = true;
      player.hitPoint--;
    }
    if (bullet.needRemove()) bulletList.remove(i);
  }
  
  fill(0, 0, 255);
  for (int i = laserList.size()-1; i >= 0; i--) {
    Laser laser = laserList.get(i);
    laser.move();
    laser.draw();
    if (collision(enemy.x, enemy.y, 20, 20, laser.x, laser.y, laser.w, laser.h)) {
      laser.hit = true;
      enemy.hitPoint--;
    }
    if (laser.needRemove()) laserList.remove(i);
  }
  
  fill(167, 87, 168);
  enemy.move();
  enemy.draw();
  
  player.move();
  player.draw();

  fill(0);
  text("Player:" + nf(player.hitPoint, 3) , 20, 20);
  text("Enemy:" + nf(enemy.hitPoint, 3)  , 20, 40); 

  if (player.hitPoint == 0 || enemy.hitPoint == 0)
    noLoop();
}

boolean collision(float x1, float y1, float w1, float h1,
                  float x2, float y2, float w2, float h2) {
  if (x1 + w1/2 < x2 - w2/2) return false;
  if (x2 + w2/2 < x1 - w1/2) return false;
  if (y1 + h1/2 < y2 - h2/2) return false;
  if (y2 + h2/2 < y1 - h1/2) return false;
  return true;
}

class Bullet {
  float x;
  float y;
  float angle;
  float speed;
  float angleSpeed;
  boolean hit = false;
  
  Bullet (float x, float y, float angle, float speed, float angleSpeed) {
    this.x = x; 
    this.y = y;
    this.angle = angle;
    this.speed = speed;
    this.angleSpeed = angleSpeed;
  }
  
  void move() {
    angle = (angle + angleSpeed) % 360;
    x += cos(radians(angle)) * speed;
    y += sin(radians(angle)) * speed;
  }
  
  void draw() {
    ellipse(x, y, 10, 10);
  }
  
  boolean needRemove() {
    return x < 0 || x > width || y < 0 || y > height || hit;
  }
}

class Enemy {
  float x = width / 2;
  float y = height / 3;
  int angle = 0;
  int hitPoint = 30;
  
  void move() {
    angle = (angle + 1) % 360;
    x += cos(radians(angle)) * 2;
    y += sin(radians(angle*2 + 90)) * 3;    
  }
  
  void draw() {
    rect(x-10, y-10, 20, 20);     
    if (frameCount % 90 == 0) circleShot();
    if (frameCount % 10 == 0) slowCurveShot();
    if (frameCount % 120 == 0) snipeShot();
  }
  
  void circleShot() {
    for (float degree = 0; degree < 360; degree += 10) {
      Bullet bullet = new Bullet(x, y, degree, 2, 0);
      bulletList.add(bullet);
    }
  }
  
  void slowCurveShot() {
    Bullet bullet = new Bullet(x, y, angle, 1, 0.2);
    bulletList.add(bullet);
  }
  
  void snipeShot() {
    float dx = player.x - x;
    float dy = player.y - y;
    float degree = degrees(atan2(dy,dx));
    Bullet bullet = new Bullet(x, y, degree, 2, 0);
    bulletList.add(bullet);
  }
}

class Player {
  float x = width / 2;
  float y = height - 10;
  int hitPoint = 10;
  PImage img;
  int scale;
  
  Player(PImage _img, float _x, float _y, int _scale) {
    img = _img;
    x = _x;
    y = _y;
    scale = _scale;
  }
  
  void move() {
    if (keyPressed) {
      switch (key) {
        case 'w':    
        y -= 2; 
        break; 
        case 's':  
        y += 2; 
        break; 
        case 'a':  
        x -= 2; 
        break; 
        case 'd': 
        x += 2; 
        break; 
        case ' ':
        laserShot();
        break;
      }
    }
    if (x-10 < 0)      x = 10;
    if (x+10 > width)  x = width-10;
    if (y-10 < 0)      y = 10;
    if (y+10 > height) y = height-10;
  }
    
  void draw() {
    image(img, x, y, width/15, height/15);
  }

  void laserShot() {
    laserList.add(new Laser(x, y, -90, 2, 20));
  }
}

class Laser extends Bullet {
  float w;
  float h;
  Laser (float x, float y, float angle, float w, float h) {
    super(x, y, angle, 3, 0);
    this.w = w;
    this.h = h;
  }
  void draw() {
    rect(x-w/2, y-h/2, w, h);
  }
}