//class Being {
//  PVector loc;
//  PVector vel;
//  PVector acc;
//  float tx, ty, tz;
//  float px, py;
//  float hunger;
//  float speed;
//  float maxforce;
//  float maxspeed;
//  float nx, ny = 0.0;
//  float yoff = 0.0;
//  boolean foodState = false;
//  boolean moveState = true;

//  Being(float _x, float _y) {
//    loc = new PVector(_x, _y);
//    acc = new PVector(0, 0);
//    vel = new PVector(0, 0);

//    px = loc.x;
//    py = loc.y;
//    hunger = 1;
//    maxspeed = 4;
//    maxforce = 0.1;

//    tx = random(100);
//    ty = random(10000);
//    tz = random(10);
//  }

//  void display() {
//    if (hunger>2) {
//      fill(255);
//    } else {
//      fill(51);
//    }
//    rect(loc.x, loc.y, 20, 20);
//  }

//  void move() {
//    //if (hunger>3) {
//    //  speed = 0.5;
//    //} else {
//    //  speed = 1;
//    //}
//    //if (hunger<2) {
//    //  nx = 0;
//    //  ny = 0;
//    //} else {
//    //  nx = map(noise(tx, tz), 0, 1, -0.1, 0.1);
//    //  ny = map(noise(ty, tz), 0, 1, -0.1, 0.1);
//    //}
    
//    //acc.y = ny;
//    //acc.x = nx;
//    vel.add(acc);
//    vel.limit(maxspeed);
//    loc.add(vel);
//    acc.mult(0);


//    hunger += -0.001;
//    tx += .1;
//    ty += .1;
//    tz += .1;
////println(acc);

//    //println("n: "+nx);
//  }
//  void applyForce(PVector force) {
//    acc.add(force);
//  }


//  void arrive(PVector target) {
//    PVector desired = PVector.sub(target, loc);

//    // The distance is the magnitude of
//    // the vector pointing from
//    // location to target.
//    float d = desired.mag();
//    desired.normalize();
//    // If we are closer than 100 pixels...
//    if (d < 100) {
//      //[full] ...set the magnitude
//      // according to how close we are.
//      float m = map(d, 0, 100, 0, maxspeed);
//      desired.mult(m);
//      //[end]
//    } else {
//      // Otherwise, proceed at maximum speed.
//      desired.mult(maxspeed);
//    }

//    // The usual steering = desired - velocity
//    PVector steer = PVector.sub(desired, vel);
//    steer.limit(maxforce);
//    //if (hunger<2) {
//      applyForce(steer);
//      //println("h: "+acc.x);
//    //}
//  }

//  void wall() {
//    if (loc.x > width) {
//      //PVector desired = new PVector(maxspeed, vel.x);
//      //PVector steer = PVector.sub(desired, vel);
//      //steer.limit(maxforce);
//      //applyForce(steer);
//      loc.x = 0;
//      px = 0;
//    } else if (loc.x < 0) {
//      loc.x = width;
//      px = width;
//    }
//    if (loc.y > height) {
//      loc.y = 0;
//      py = 0;
//    } else if (loc.y < 0) {
//      loc.y = height;
//      py = height;
//    }
//  }
//}
