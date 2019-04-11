ArrayList<Bullet> bulletList;
ArrayList<Laser> laserList;
Enemy enemy;
Player player;
int state;

// 各キーが押されているか否かを管理するフラグです
boolean keyUp = false;
boolean keyLeft = false;
boolean keyRight = false;
boolean keyDown = false;
boolean space = false;

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
  state = 0;

  bulletList = new ArrayList<Bullet>();
  laserList = new ArrayList<Laser> ();
  enemy = new Enemy();
  player = new Player(loadImage("test01.png"), float(width / 2), float((height * 3) / 4), 1);
}

/**
 * 1秒間に60回呼ばれるメソッドです
 * ゲームの処理はここで書かれています
 */
void draw() {
  int nextState= 0;
  if(state == 0){
    nextState = title();
  } else if(state == 1) {
    nextState = game();
  } else if(state == 2) {
    nextState = ending();
  }
  state = nextState;
}

/* タイトルの描画メソッドです　*/
int title(){
  setup();
  textSize(30);
  fill(0);
  text("Press z key to start", width * 0.25, height * 0.5);
  if(keyPressed && key == 'z'){
    return 1;
  }
  return 0;
}

/* キーを押した際の動きと見えない壁の配置のメソッドです　*/
void keyPressed() {
  if (key == 'w') {
    keyUp = true;
    return;
  }

  if (key == 'a') {
    keyLeft = true;
    return;
  }

  if (key == 'd') {
    keyRight = true;
    return;
  }

  if (key == 's') {
    keyDown = true;
    return;
  }

  if (key == ' ') {
    space = true;
    return;
  }
}

void keyReleased() {
  if (key == 'w') {
    keyUp = false;
    return;
  }

  if (key == 'a') {
    keyLeft = false;
    return;
  }

  if (key == 'd') {
    keyRight = false;
    return;
  }

  if (key == 's') {
    keyDown = false;
    return;
  }

  if (key == ' ') {
    space = false;
    return;
  }
}

/**
 * 当たり判定をするメソッドです
 */
boolean collision(GameObject gameObject1, GameObject gameObject2) {
  float distanceX = gameObject1.getX() - gameObject2.getX();
  float distanceY = gameObject1.getY() - gameObject2.getY();
  /* 2乗同士で判定 */
  float sqDistance = sq(distanceX) + sq(distanceY);
  return sqDistance < sq(gameObject1.getHitRadius() + gameObject2.getHitRadius());
}

/* ゲームを描画するメソッドです */

int game() {
  fill(255);
  rect(0, 0, width, height);

  fill(255, 0, 0);
  for (int i = 0; i < bulletList.size(); i++) {
    Bullet bullet = bulletList.get(i);
    bullet.move();
    bullet.draw();
    if (collision(player, bullet)) {
      bullet.setIsHit(true);
      player.sufferDamage();
    }
    if (bullet.needRemove()){
      bulletList.remove(i);
    }
  }

  fill(0, 0, 255);
  for (int i = 0; i < laserList.size(); i++) {
    Laser laser = laserList.get(i);
    laser.move();
    laser.draw();
    if (collision(enemy, laser)) {
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

  player.update();
  player.draw();

  fill(0);
  text("Player:" + nf(player.getHitPoint(), 3) , 20, 20);
  text("Enemy:" + nf(enemy.getHitPoint(), 3)  , 20, 40);

  /* 自機か敵機のHPが0になればゲームを止めます */
  if (player.getHitPoint() <= 0 || enemy.getHitPoint() <= 0){
    return 2;
  }
  return 1;
}

/* ゲームが終わった際に呼び出されるメソッドです */

int ending(){
  textSize(32);
  fill(0);
  text("Thankyou for Playing!", width * 0.2, height * 0.4);
  textSize(30);
  fill(0, 0, 255);
  text("Press 'a' to restart.", width * 0.25, height * 0.7);
  if(keyPressed && key == 'a') {
    return 0;
  }
  return 2;
}
