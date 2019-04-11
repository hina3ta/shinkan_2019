/**
 * 弾を表すクラスです
 */
public class Bullet extends GameObject{
  float angle;
  float speed;
  float angleSpeed;
  boolean hit = false;

  Bullet (float x, float y, float angle, float speed, float angleSpeed) {
    super(x, y);
    this.angle = angle;
    this.speed = speed;
    this.angleSpeed = angleSpeed;
  }

  /**
   * 弾を動かすメソッドです
   */
  void move() {
    angle = (angle + angleSpeed) % 360;
    setX(getX() + cos(radians(angle)) * speed);
    setY(getY() + sin(radians(angle)) * speed);
  }

  /**
   * 弾を画面に表示するメソッドです
   */
  void draw() {
    ellipse(getX(), getY(), 10, 10);
  }

  /**
   * この弾を消す必要があるかどうか判定するメソッドです
   */
  boolean needRemove() {
    return getX() < 0 || getX() > width || getY() < 0 || getY() > height || hit;
  }
}