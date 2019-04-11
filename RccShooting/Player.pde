/**
 * 自機を表すクラスです
 */
public class Player extends Character {
  PImage img;
  int scale;

  int speed;

  Player(PImage img, float x, float y, int scale) {
    super(width / 2, height - 50, 10, 10);
    this.img = img;
    this.scale = scale;
    this.speed = 5;
  }

  /**
   * 自機を画面に表示するメソッドです
   */
  void draw() {
    // TODO : 定数定義
    image(img, getX() - 16, getY() - 16, 32, 32);
  }

  void setSpeed(int speed){
    this.speed = speed;
  }

  void update() {
    if (space) {
      laserList.add(new Laser(getX(), getY(), -90, 2, 20));
    }

    if (keyUp) {
      setY(getY() - speed);
    }

    if (keyLeft) {
      setX(getX() - speed);
    }

    if (keyRight) {
      setX(getX() + speed);
    }

    if (keyDown) {
      setY(getY() + speed);
    }
  }
}
