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
  float timeAlive;
  float r = 1;
  float col;
  float dist;

  DNA dna;

  Being(PVector l, DNA dna_) {
    dna = dna_;

    col = map(dna.genes[0][0], 0, 1, 0, 255);
    maxspeed = map(dna.genes[1][0], 0, 1, 1, 4);

    loc = new PVector(l.x, l.y);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);

    px = loc.x;
    py = loc.y;
    hunger = 3;
    //maxspeed = 3;
    maxforce = 0.1;
    timeAlive=0;

    tx = random(100);
    ty = random(10000);
    tz = random(10);
  }

  void control(Food target) {
    if (hunger<2) {
      foodState(target);
    } else {
      neutralState(target);
    }
    eat(target);
    update();
    display();
  }

  void foodState(Food target) {
    hunt(target);
  }
  void neutralState(Food target) {
    nx = map(noise(tx, tz), 0, 1, -0.1, 0.1);
    ny = map(noise(ty, tz), 0, 1, -0.1, 0.1);

    acc.y = ny;
    acc.x = nx;
  }

  Being separate(ArrayList<Being> vehicles) {
    float desiredseparation = r*2; //insert 'r' here
    for (Being other : vehicles) {
      float d = PVector.dist(loc, other.loc);
      if ((d > 0) && (d < desiredseparation)) {
        if (other.hunger>=5) {
          bing = other;

          //dna = matingState(other);
        }
      }
    }
    //println(hunger);
    return bing;
  }

  //DNA separate(ArrayList<Being> vehicles) {
  //  DNA dna = new DNA();
  //  float desiredseparation = r*2; //insert 'r' here
  //  for (Being other : vehicles) {
  //    float d = PVector.dist(loc, other.loc);
  //    if ((d > 0) && (d < desiredseparation)) {
  //      if (other.hunger>=5) {

  //        dna = matingState(other);
  //      } 
  //    }
  //  }
  //  //println(hunger);
  //  return dna;
  //}
  DNA matingState(Being mate) {
    //println("og: "+dna.genes[0][0]);
    //println("mate: "+mate.dna.genes[0][0]);
    float va1 = dna.genes[0][0];
    float va2 = mate.dna.genes[0][0];
    float vb1 = dna.genes[1][0];
    float vb2 = mate.dna.genes[1][0];
    DNA dna = new DNA();
    if (random(1)<0.5) {
      dna.genes[0][0] = va1;
    } else {
      dna.genes[0][0] = va2;
    }
    if (random(1)<0.5) {
      dna.genes[1][0] = vb1;
    } else {
      dna.genes[1][0] = vb2;
    }
    println("sup");
    println(hunger+" "+mate.hunger);
    return dna;

    //+" "+mate.hunger);
  }

  /*
  void separate(ArrayList<Being> vehicles) {
   float desiredseparation = r*5; //insert 'r' here
   PVector sum = new PVector();
   int count = 0;
   for (Being other : vehicles) {
   float d = PVector.dist(loc, other.loc);
   if ((d > 0) && (d < desiredseparation)) {
   PVector diff = PVector.sub(loc, other.loc);
   diff.normalize();
   diff.div(d);
   sum.add(diff);
   count++;
   }
   }
   */

  void display() {
    //if (hunger>3) {
    //  fill(255);
    //} else {
    //  fill(51);
    //}
    fill(col, 255-col, col);
    noStroke();
    r=map(timeAlive, 0, 1200, 1, 7);
    float theta = vel.heading() + PI/2;
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
    //rect(loc.x, loc.y, 20, 20);
  }

  void update() {
    wall();
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);
    hunger += -0.001;
    tx += 0.1;
    ty += 0.1;
    tz += 0.1;

    timeAlive++;
  }

  void getDistance(Food f) {
    ArrayList<PVector> food = f.getFood();
    for (int i = food.size()-1; i >= 0; i--) {
      PVector foodposition = food.get(i);
      float d = PVector.dist(loc, foodposition);
    }
  }
  void eat(Food f) {
    ArrayList<PVector> food = f.getFood();
    for (int i = food.size()-1; i >= 0; i--) {
      PVector foodposition = food.get(i);
      float d = PVector.dist(loc, foodposition);

      // If we are, juice up our strength!
      if (d < r*2) {
        //health += 100; 
        hunger++;
        food.remove(i);
      }
    }
  }
  void hunt(Food f) {
    ArrayList<PVector> food = f.getFood();
    for (int i = food.size()-1; i >= 0; i--) {
      PVector foodposition = food.get(i);
      float d = PVector.dist(loc, foodposition);
      if (d<50) {
        arrive(foodposition);
      }
    }
  }

  void applyForce(PVector force) {
    acc.add(force);
  }
  void arrive(PVector target) {
    PVector desired = PVector.sub(target, loc);
    float d = desired.mag();
    desired.normalize();
    if (d < 30) {
      float m = map(d, 0, 30, 0, maxspeed);
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
    PVector desired = vel.copy();
    if (loc.x > width-15) {
      desired = new PVector(maxspeed * -1, vel.y);
    } else if (loc.x < 15) {
      desired = new PVector(maxspeed, vel.y);
    }
    if (loc.y > height-15) {
      desired = new PVector(vel.x, maxspeed * -1);
    } else if (loc.y < 15) {
      desired = new PVector(vel.x, maxspeed);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);
    applyForce(steer);
  }

  //void separate(ArrayList<Being> vehicles) {
  //  float desiredseparation = r*5; //insert 'r' here
  //  PVector sum = new PVector();
  //  int count = 0;
  //  for (Being other : vehicles) {
  //    float d = PVector.dist(loc, other.loc);
  //    if ((d > 0) && (d < desiredseparation)) {
  //      PVector diff = PVector.sub(loc, other.loc);
  //      diff.normalize();
  //      diff.div(d);
  //      sum.add(diff);
  //      count++;
  //    }
  //  }
  //  if (count > 0) {
  //    sum.div(count);
  //    sum.normalize();
  //    sum.mult(maxspeed);
  //    PVector steer = PVector.sub(sum, vel);
  //    steer.limit(1);
  //    applyForce(steer);
  //  }
  //}
}
