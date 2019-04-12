/**
 * 敵機を表すクラスです
 */
class Enemy extends Character {
  private int angle;
  int scale;
  PImage img;

  Enemy(PImage img, float x, float y, int scale) {
    super(width / 2, height / 3, 15, 100);
    this.img = img;
    this.scale = scale;
    this.angle = 0;
  }

  /**
   * 敵機を動かすメソッドです
   */
  void move() {
    angle = (angle + 1) % 360;
    setX(getX() + cos(radians(angle)) * 2);
    setY(getY() + sin(radians(angle*2 + 90)) * 3);
  }

  /**
   * 敵機を画面に表示するメソッドです
   */
  void draw() {
    image(img, getX() - 16, getY() - 16, 32, 32);
    if (frameCount % 90 == 0) circleShot();
    if (frameCount % 10 == 0) slowCurveShot();
    if (frameCount % 120 == 0) snipeShot();
  }

  /**
   * 円形の攻撃をするメソッドです
   */
  void circleShot() {
    for (float degree = 0; degree < 360; degree += 15) {
      Bullet bullet = new Bullet(getX(), getY(), degree, 2, 0);
      bulletList.add(bullet);
    }
  }

  /**
   * 曲線の攻撃をするメソッドです
   */
  void slowCurveShot() {
    Bullet bullet = new Bullet(getX(), getY(), angle, 1, 0.2);
    bulletList.add(bullet);
  }

  /**
   * 自機に向かって攻撃をするメソッドです
   */
  void snipeShot() {
    float dx = player.getX() - getX();
    float dy = player.getY() - getY();
    float degree = degrees(atan2(dy, dx));
    Bullet bullet = new Bullet(getX(), getY(), degree, 2, 0);
    bulletList.add(bullet);
  }
}
