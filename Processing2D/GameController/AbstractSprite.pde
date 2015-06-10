abstract class AbstractSprite implements Sprite {
  PVector position;
  PVector velocity;
  PShape graphic;
  int radius;

  AbstractSprite(PVector position, PVector velocity) {
    this.position = position;
    this.velocity = velocity;
  }

  void create(PShape graphic, int radius) {
    this.graphic = graphic;
    this.radius = radius;
  }

  void destroy() {
    sprites.remove(this);
    enemies.remove(this);
  }

  void update() {
    if (this != player) {
      if (isRightBound(this))
        velocity = new PVector(-1 * velocity.x, 0);
      else if (isLeftBound(this))
        velocity = new PVector(-1 * velocity.x, 0);
    }
    position.add(velocity);
  }

  void display() {
    shape(graphic, position.x, position.y);
  }

  void updateAndDisplay() {
    update();
    display();
  }

  //http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
  //http://cgp.wikidot.com/circle-to-circle-collision-detection
  boolean isColliding(ProjectileSprite projectile, HostileSprite hostile) {
    float dx = projectile.position.x - hostile.position.x;
    float dy = projectile.position.y - hostile.position.y;
    float rr = projectile.radius + hostile.radius;
    if (dx * dx + dy * dy < rr * rr)
      return true;
    else
      return false;
  }
}
