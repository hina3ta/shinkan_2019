/**
 * すべての物体に対して共通なものを表すクラスです
 * @author Yukiho YOSHIEDA
 */
class GameObject {
    private float x;
    private float y;

    GameObject(float x, float y){
        this.x = x;
        this.y = y;
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