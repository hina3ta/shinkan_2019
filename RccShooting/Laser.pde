/**
 * レーザーを表すクラスです
 */
class Laser extends Bullet {
  private float w;
  private float h;

  Laser (float x, float y, float angle, float w, float h) {
    super(x, y, angle, 3, 0);
    this.w = w;
    this.h = h;
  }

  /**
   * レーザーを画面に描画するメソッドです
   */
  void draw() {
    rect(getX() - w / 2, getY() - h / 2, w, h);
  }

  /**
   * wの値を取得するメソッドです
   */
  float getW(){
    return w;
  }

  /**
   * hの値を取得するメソッドです
   */
  float getH(){
    return h;
  }
}
