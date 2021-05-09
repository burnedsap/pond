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
  float xoff = 0.0;
  float yoff = 0.0;

  Being(float _x, float _y) {
    loc = new PVector(_x, _y);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);

    px = loc.x;
    py = loc.y;
    hunger = 1;
    maxspeed = 4;
    maxforce = 0.1;
  }

  void display() {
    if (hunger>3) {
      fill(255);
    } else {
      fill(51);
    }
    rect(loc.x, loc.y, 20, 20);
  }

  void move() {
    if (hunger>3) {
      speed = 0.5;
    } else {
      speed = 1;
    }

    float nx = map(noise(xoff), 0, 1, -1, 1);
    float ny= map(noise(yoff), 0, 1, -1, 1);
    println(nx);
    acc.y+=ny/10;
    acc.x+=nx/10;
    //acc.x += map(noise(tx, tz), 0, 1, -speed, speed);
    //acc.y += map(noise(ty, tz), 0, 1, -speed, speed);
    //acc.add(new PVector(random(-1, 1), random(-1, 1)));
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);


    hunger += -0.001;
    xoff += .01;
    yoff += .01;
  }
  void applyForce(PVector force) {
    acc.add(force);
  }

  //void seek(PVector target) {
  //  PVector desired = PVector.sub(target, loc);  // A vector pointing from the position to the target
  //  // Scale to maximum speed
  //  //desired.normalize();
  //  //desired.mult(1);

  //  // Above two lines of code below could be condensed with new PVector setMag() method
  //  // Not using this method until Processing.js catches up
  //  desired.setMag(maxspeed);

  //  // Steering = Desired minus Velocity
  //  PVector steer = PVector.sub(desired, vel);
  //  steer.limit(maxforce);
  //  applyForce(steer);
  //  //acc.add(steer);// Limit to maximum steering force
  //}

  void arrive(PVector target) {
    PVector desired = PVector.sub(target, loc);

    // The distance is the magnitude of
    // the vector pointing from
    // location to target.
    float d = desired.mag();
    desired.normalize();
    // If we are closer than 100 pixels...
    if (d < 100) {
      //[full] ...set the magnitude
      // according to how close we are.
      float m = map(d, 0, 100, 0, maxspeed);
      desired.mult(m);
      //[end]
    } else {
      // Otherwise, proceed at maximum speed.
      desired.mult(maxspeed);
    }

    // The usual steering = desired - velocity
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
