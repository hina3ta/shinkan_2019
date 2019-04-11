public class Laser extends Bullet {
  float w;
  float h;
  Laser (float x, float y, float angle, float w, float h) {
    super(x, y, angle, 3, 0);
    this.w = w;
    this.h = h;
  }
  void draw() {
    rect(x-w/2, y-h/2, w, h);
  }
}