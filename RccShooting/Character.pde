/**
 * キャラクターを表すクラスです
 */
class Character extends GameObject {
    private int hitPoint;

    Character(float x, float y, int hitPoint){
        super(x, y);
        this.hitPoint = hitPoint;
    }

    /**
     * hitPointを取得します
     */
    int getHitPoint(){
        return hitPoint;
    }

    /**
    * ダメージ計算をするメソッドです
    */
    void sufferDamage(){
        hitPoint--;
    }
}