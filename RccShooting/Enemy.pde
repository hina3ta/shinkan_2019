/**
 * 敵機を表すクラスです
 */
public class Enemy {
  float x = width / 2;
  float y = height / 3;
  int angle = 0;
  int hitPoint = 30;

  /**
   * 敵機を動かすメソッドです
   */
  void move() {
    angle = (angle + 1) % 360;
    x += cos(radians(angle)) * 2;
    y += sin(radians(angle*2 + 90)) * 3;
  }

  /**
   * 敵機を画面に表示するメソッドです
   */
  void draw() {
    rect(x-10, y-10, 20, 20);
    if (frameCount % 90 == 0) circleShot();
    if (frameCount % 10 == 0) slowCurveShot();
    if (frameCount % 120 == 0) snipeShot();
  }

  /**
   * 円形の攻撃をするメソッドです
   */
  void circleShot() {
    for (float degree = 0; degree < 360; degree += 10) {
      Bullet bullet = new Bullet(x, y, degree, 2, 0);
      bulletList.add(bullet);
    }
  }

  /**
   * 曲線の攻撃をするメソッドです
   */
  void slowCurveShot() {
    Bullet bullet = new Bullet(x, y, angle, 1, 0.2);
    bulletList.add(bullet);
  }

  /**
   * 自機に向かって攻撃をするメソッドです
   */
  void snipeShot() {
    float dx = player.x - x;
    float dy = player.y - y;
    float degree = degrees(atan2(dy,dx));
    Bullet bullet = new Bullet(x, y, degree, 2, 0);
    bulletList.add(bullet);
  }
}