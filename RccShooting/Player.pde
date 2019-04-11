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
   * 特定のキーが押されたときに移動するためのメソッドです
   */
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

  /**
   * 自機を画面に表示するメソッドです
   */
  void draw() {
    image(img, 0, 0, 32, 32);
  }

  /**
   * 攻撃をするためのメソッドです
   */
  void laserShot() {
    laserList.add(new Laser(x, y, -90, 2, 20));
  }
}