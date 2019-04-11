/**
 * 弾を表すクラスです
 */
public class Bullet {
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

  /**
   * 弾を動かすメソッドです
   */
  void move() {
    angle = (angle + angleSpeed) % 360;
    x += cos(radians(angle)) * speed;
    y += sin(radians(angle)) * speed;
  }

  /**
   * 弾を画面に表示するメソッドです
   */
  void draw() {
    ellipse(x, y, 10, 10);
  }

  /**
   * この弾を消す必要があるかどうか判定するメソッドです
   */
  boolean needRemove() {
    return x < 0 || x > width || y < 0 || y > height || hit;
  }
}