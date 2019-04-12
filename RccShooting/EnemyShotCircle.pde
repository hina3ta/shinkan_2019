/**
 * 円形の攻撃をする敵のクラスです
 */
class EnemyShotCircle extends Character {
  private int angle;

  EnemyShotCircle(){
    super(width / 2, height / 4, 10, 20);
    angle = 0;
  }

/**
 * 円形攻撃のみを行う敵の動作メソッドです
 */
  void move() {
    angle = (angle + 1) % 360;
     setX(getX() + cos(radians(angle)) * 4);
    }

/**
 * 円形攻撃のみを行う敵の表示メソッドです
 */
  void draw() {
    rect(getX() -10, getY() - 10, 20, 20);
    if (frameCount % 60 == 0) circleShot();
  }

  /**
   * 円形の攻撃をするメソッドです
   */
  void circleShot() {
    for (float degree = 0; degree < 360; degree += 25) {
      Bullet bullet = new Bullet(getX(), getY(), degree, 2, 0);
      bulletList.add(bullet);
    }
  }
}
