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