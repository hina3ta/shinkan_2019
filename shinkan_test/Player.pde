public class Player {
  float x = width / 2;
  float y = height - 10;
  int hitPoint = 10;
  PImage img;
  int scale;

  Player(PImage _img, float _x, float _y, int _scale) {
    img = _img;
    x = _x;
    y = _y;
    scale = _scale;
  }

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

  void draw() {
    image(img, x, y, width/15, height/15);
  }

  void laserShot() {
    laserList.add(new Laser(x, y, -90, 2, 20));
  }
}