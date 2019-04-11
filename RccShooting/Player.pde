/**
 * 自機を表すクラスです
 */
public class Player {
  float x = width / 2;
  float y = height - 10;
  int hitPoint = 10;
  PImage img;
  int scale;

  Player(PImage img, float x, float y, int scale) {
    this.img = img;
    this.x = x;
    this.y = y;
    this.scale = scale;
  }

  /**
   * 自機を画面に表示するメソッドです
   */
  void draw() {
    image(img, x, y, 32, 32);
  }

  /**
   * 攻撃をするためのメソッドです
   */
  void laserShot() {
    laserList.add(new Laser(x, y, -90, 2, 20));
  }
}