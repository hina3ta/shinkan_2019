public class Enemy {
  float x = width / 2;
  float y = height / 3;
  int angle = 0;
  int hitPoint = 30;

  void move() {
    angle = (angle + 1) % 360;
    x += cos(radians(angle)) * 2;
    y += sin(radians(angle*2 + 90)) * 3;
  }

  void draw() {
    rect(x-10, y-10, 20, 20);
    if (frameCount % 90 == 0) circleShot();
    if (frameCount % 10 == 0) slowCurveShot();
    if (frameCount % 120 == 0) snipeShot();
  }

  void circleShot() {
    for (float degree = 0; degree < 360; degree += 10) {
      Bullet bullet = new Bullet(x, y, degree, 2, 0);
      bulletList.add(bullet);
    }
  }

  void slowCurveShot() {
    Bullet bullet = new Bullet(x, y, angle, 1, 0.2);
    bulletList.add(bullet);
  }

  void snipeShot() {
    float dx = player.x - x;
    float dy = player.y - y;
    float degree = degrees(atan2(dy,dx));
    Bullet bullet = new Bullet(x, y, degree, 2, 0);
    bulletList.add(bullet);
  }
}