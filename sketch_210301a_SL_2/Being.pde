class Being {
  PVector loc;
  PVector vel;
  PVector acc;
  float tx, ty, tz;
  float px, py;
  float hunger;
  float speed;
  float maxforce;
  float maxspeed;
  float nx, ny = 0.0;
  Being(float _x, float _y) {
    loc = new PVector(_x, _y);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);

    px = loc.x;
    py = loc.y;
    hunger = 1;
    maxspeed = 3;
    maxforce = 0.1;

    tx = random(100);
    ty = random(10000);
    tz = random(10);
  }

  //void control() {
  //  if (hunger<2) {
  //    foodState();
  //  } else {
  //    neutralState();
  //  }
  //}

  void foodState(PVector target) {
    if(hunger<2) {
      arrive(target);
    }
    update();
    //display();
  }
  void neutralState() {
    nx = map(noise(tx, tz), 0, 1, -0.1, 0.1);
    ny = map(noise(ty, tz), 0, 1, -0.1, 0.1);

    acc.y = ny;
    acc.x = nx;
    update();
    display();
  }

  void display() {
    if (hunger>2) {
      fill(255);
    } else {
      fill(51);
    }
    rect(loc.x, loc.y, 20, 20);
  }

  void update() {

    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);
    hunger += -0.001;
    tx += 0.1;
    ty += 0.1;
    tz += 0.1;
    wall();
  }

  void applyForce(PVector force) {
    acc.add(force);
  }
  void arrive(PVector target) {
    PVector desired = PVector.sub(target, loc);
    float d = desired.mag();
    desired.normalize();
    if (d < 50) {
      float m = map(d, 0, 50, 0, maxspeed);
      desired.mult(m);
      //[end]
    } else {
      desired.mult(maxspeed);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);
    applyForce(steer);
  }
  void wall() {
    if (loc.x > width) {
      //PVector desired = new PVector(maxspeed, vel.x);
      //PVector steer = PVector.sub(desired, vel);
      //steer.limit(maxforce);
      //applyForce(steer);
      loc.x = 0;
      px = 0;
    } else if (loc.x < 0) {
      loc.x = width;
      px = width;
    }
    if (loc.y > height) {
      loc.y = 0;
      py = 0;
    } else if (loc.y < 0) {
      loc.y = height;
      py = height;
    }
  }
}
