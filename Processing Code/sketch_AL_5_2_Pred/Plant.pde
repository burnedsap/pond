class Plant {
  PVector loc;
  PVector vel;
  PVector acc;
  float tx, ty, tz;
  float px, py;
  float maxspeed, maxforce;
  float nx, ny = 0.0;
  float r;
  float t;
  float growthRate;
  float reProd;

  Plant() {
    loc = new PVector(random(width), random(height));
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);

    r = random(0.1, 1);
    t = random(1000, 2400);
    growthRate = random(0.02, 0.1);
    reProd = random(4, 6);

    maxspeed = map(r, 0, 10, 0.05, 0.5);
    maxforce = 0.9;

    px = loc.x;
    py = loc.y;

    tx = random(100);
    ty = random(10000);
    tz = random(10);
  }

  Plant(float x, float y) {
    loc = new PVector(x, y);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);

    r = random(0.1, 1);
    t = random(2000, 2800);
    growthRate = random(0.02, 0.1);
    reProd = random(4, 6);

    maxspeed = map(r, 0, 10, 0.05, 0.5);
    maxforce = 0.9;

    px = loc.x;
    py = loc.y;

    tx = random(100);
    ty = random(10000);
    tz = random(10);
  }

  void run(ArrayList<Plant> plnt) {
    wall();
    regen(plnt);
    display();
    death(plnt);
    update();
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
    if (r<10) {
      r+=growthRate;
    }
    t--;
  }

  void display() {
    noStroke();
    fill(309);
    ellipse(loc.x, loc.y, r, r);
    noFill();
    stroke(209);
    ellipse(loc.x, loc.y, r*2, r*2);
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

  void death(ArrayList<Plant> plnt) {
    for (int i = 0; i<plnt.size(); i++) {
      Plant part = plnt.get(i);
      if (part.t<=0) {
        plnt.remove(i);
      }
      if((part.loc.x>width)||(part.loc.x<0)||(part.loc.y>height)||(part.loc.y<0)) {
        plnt.remove(i);
      }
    }
  }
  void regen(ArrayList<Plant> plnt) {
    //Generate new plants if value below limit
    if (plnt.size()<minPlantVal) {
      plnt.add(new Plant());
    }


    if ((random(1) < PlantRegenVal)&&(plnt.size()<maxPlantVal)) {
      for (int i = 0; i<plnt.size(); i++) {
        Plant part = plnt.get(i);
        if (part.r>reProd) {
          if (random(1) < 0.5) {
            plnt.add(new Plant((part.loc.x+random(-50, 50)), (part.loc.y+random(-50, 50))));
          }
        }
      }
    }
  }
}


//  ArrayList getPlant() {
//    return plant;
//  }
//}
