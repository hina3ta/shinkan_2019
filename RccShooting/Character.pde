/**
 * キャラクターを表すクラスです
 */
class Character extends GameObject {
    private int hitPoint;

    Character(float x, float y, float hitRadius, int hitPoint){
        super(x, y, hitRadius);
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
