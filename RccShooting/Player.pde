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

  /**
   * 攻撃をするためのメソッドです
   */
  void laserShot() {
    laserList.add(new Laser(getX(), getY(), -90, 2, 20));
  }

  void setSpeed(int speed){
    this.speed = speed;
  }

  /**
   * 左に動かすメソッドです
   */
  void moveLeft(){
    setX(getX() - speed);
    if (getX() - speed < 0){
      setX(10);
    }
  }

  /**
   * 右に動かすメソッドです
   */
  void moveRight(){
    setX(getX() + speed);
    if (getX() + 10 > width){
      setX(width - 10);
    }
  }

  /**
   * 上に動かすメソッドです
   */
  void moveUp(){
    setY(getY() - speed);
    if (getY() - 10 < 0){
      setY(10);
    }
  }

  /**
   * 下に動かすメソッドです
   */
  void moveDown(){
    setY(getY() + speed);
    if (getY() + 10 > height){
      setY(height - 10);
    }
  }
}
