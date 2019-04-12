/**
 * すべての物体に対して共通なものを表すクラスです
 * @author Yukiho YOSHIEDA
 */
class GameObject {
  private float x;
  private float y;
  private float hitRadius;

  GameObject(float x, float y, float hitRadius){
    this.x = x;
    this.y = y;
    this.hitRadius = hitRadius;
  }

  /**
   * xの値を取得します
   */
  float getX(){
    return x;
  }

  /**
   * yの値を取得します
   */
  float getY(){
    return y;
  }

  /**
   * hitRadiusの値を取得します
   */
  float getHitRadius(){
    return hitRadius;
  }

  /**
   * xの値をセットします
   */
  void setX(float x){
    this.x = x;
  }

  /**
   * yの値をセットします
   */
  void setY(float y){
    this.y = y;
  }
}
