ArrayList<Bullet> bulletList;
ArrayList<Laser> laserList;
Enemy enemy;
Player player;

/**
 * マウスがクリックされたら呼ばれるメソッド（関数）です
 */
void mouseClicked() {
  setup();
}

/**
 * ゲームが起動したときに呼ばれるメソッド（関数）です
 */
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
  player = new Player(loadImage("test01.png"), float(width / 2), float((height * 3) / 4), 1);
}

/**
 * 1秒間に30回呼ばれるメソッドです
 * ゲームの処理はここで書かれています
 */
void draw() {
  fill(255);
  rect(0, 0, width, height);

  fill(255, 0, 0);
  for (int i = bulletList.size()-1; i >= 0; i--) {
    Bullet bullet = bulletList.get(i);
    bullet.move();
    bullet.draw();
    if (collision(player.getX(), player.getY(), 5, 5, bullet.getX(), bullet.getY(), 5, 5)) {
      bullet.setIsHit(true);
      player.sufferDamage();
    }
    if (bullet.needRemove()){
      bulletList.remove(i);
    }
  }

  fill(0, 0, 255);
  for (int i = laserList.size() - 1; i >= 0; i--) {
    Laser laser = laserList.get(i);
    laser.move();
    laser.draw();
    if (collision(enemy.getX(), enemy.getY(), 20, 20, laser.getX(), laser.getY(), laser.getW(), laser.getH())) {
      laser.setIsHit(true);
      enemy.sufferDamage();
    }
    if (laser.needRemove()){
      laserList.remove(i);
    }
  }

  fill(167, 87, 168);
  enemy.move();
  enemy.draw();

  player.draw();

  fill(0);
  text("Player:" + nf(player.getHitPoint(), 3) , 20, 20);
  text("Enemy:" + nf(enemy.getHitPoint(), 3)  , 20, 40);

  /* 自機か敵機のHPが0になればゲームを止めます */
  if (player.getHitPoint() == 0 || enemy.getHitPoint() == 0){
    noLoop();
  }
}
/* キーを押した際の動きと見えない壁の配置のメソッドです　*/
void keyPressed() {
  if (key == 'a') {
    player.moveLeft();
  } else if (key == 'd') {
    player.moveRight();
  } else if (key == 'w') {
    player.moveUp();
  } else if (key == 's') {
    player.moveDown();
  } else if (key == ' ') {
    player.laserShot();
  }
}

/**
 * 当たり判定をするメソッドです
 */
boolean collision(float x1, float y1, float w1, float h1,
                  float x2, float y2, float w2, float h2) {
  if (x1 + w1/2 < x2 - w2/2) return false;
  if (x2 + w2/2 < x1 - w1/2) return false;
  if (y1 + h1/2 < y2 - h2/2) return false;
  if (y2 + h2/2 < y1 - h1/2) return false;
  return true;
}