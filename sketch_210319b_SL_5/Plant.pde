class Plant {
  PVector loc;
  PVector vel;
  PVector acc;
  float tx, ty, tz;
  float px, py;
  float maxspeed, maxforce;
  float nx, ny = 0.0;

  Plant() {
    loc = new PVector(random(width), random(height));
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);

    maxspeed = 0.2;
    maxforce = 0.9;

    px = loc.x;
    py = loc.y;

    tx = random(100);
    ty = random(10000);
    tz = random(10);
  }

  void run(ArrayList<Plant> plnt) {
    update();
    wall();
    regen(plnt);
    display();
  }

  void update() {
    nx = map(noise(tx, tz), 0, 1, -0.1, 0.1);
    ny = map(noise(ty, tz), 0, 1, -0.1, 0.1);
    acc.y = ny;
    acc.x = nx;
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);
    tx += 0.1;
    ty += 0.1;
    tz += 0.01;
  }

  void display() {
    noStroke();
    fill(359);
    ellipse(loc.x, loc.y, 10, 10);
  }
  void wall() {
    PVector desired = vel.copy();
    if (loc.x > width-30) {
      desired = new PVector(maxspeed * -1, vel.y);
    } else if (loc.x < 30) {
      desired = new PVector(maxspeed, vel.y);
    }
    if (loc.y > height-30) {
      desired = new PVector(vel.x, maxspeed * -1);
    } else if (loc.y < 30) {
      desired = new PVector(vel.x, maxspeed);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);
    applyForce(steer);
  }
  void applyForce(PVector force) {
    acc.add(force);
  }
  void regen(ArrayList<Plant> plnt) {
    if (random(1) < 0.001) {
      plnt.add(new Plant());
    }

    if (plnt.size()<10) {
      plnt.add(new Plant());
    }
  }
}


//  ArrayList getPlant() {
//    return plant;
//  }
//}
