class Plop {
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
  float htr;

  DNA dna;

  Plop(PVector l, DNA dna_) {
    dna = dna_;
    htr = map(dna.genes[0][0], 0, 1, 4, 7);
    col = map(dna.genes[1][0], 0, 1, 0, 255);
    maxspeed = map(dna.genes[1][0], 0, 1, 1, 2);

    loc = new PVector(l.x, l.y);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);

    px = loc.x;
    py = loc.y;
    hunger = 3;
    //maxspeed = 3;
    maxforce = 0.1;
    timeAlive=random(4000, 5000);

    tx = random(100);
    ty = random(10000);
    tz = random(10);
  }

  void neutral() {
    nx = map(noise(tx, tz), 0, 1, -0.1, 0.1);
    ny = map(noise(ty, tz), 0, 1, -0.1, 0.1);
    acc.y = ny;
    acc.x = nx;
  }

  void disp(ArrayList<Being> f) {
    if (hunger<10) {
      eat(f);
    }
    update();
    display();
  }



  void hunt(ArrayList<Being> f, ArrayList<Plop> vehicles) {

    
    FloatList foodist = new FloatList();
    
    for (int i = 0; i<f.size(); i++) {
      Being Mpart = f.get(i);
      PVector foodposition = Mpart.loc;
      float d = PVector.dist(loc, foodposition);
      foodist.append(d);
    }
    
    float minVal = foodist.min();
    int temp = foodist.index(minVal);
    PVector foodposition = f.get(temp).loc;

    FloatList matedist = new FloatList();
    for (int i = 0; i<vehicles.size(); i++) {
      Plop Mpart = vehicles.get(i);
      //if (Mpart.hunger>6) {
      float d = PVector.dist(loc, Mpart.loc);
      if ((d==0.0)) {
        matedist.append(1000);
      } else {
        matedist.append(d);
      }
    }
    //PVector matePosition = new PVector();
    //float minMate = 1000;
    float minMate= matedist.min();
    int newTemp = matedist.index(minMate);
    Plop exo = vehicles.get(newTemp);
    //if(exo.hunger>6) {
    //println(minMate);
    //}
    PVector matePosition = vehicles.get(newTemp).loc;
    //}
    //PVector matePosition = vehicles.get(newTemp).loc;

    if ((minVal<100)&&(hunger<4)) {
      stroke(51, 50);
      line(loc.x, loc.y, foodposition.x, foodposition.y);
      arrive(foodposition);
    } else if ((minMate<70)&&(hunger>htr)&&(exo.hunger>exo.htr)) {
      //mate(vehicles);
      stroke(255, 0, 0, 50);
      line(loc.x, loc.y, matePosition.x, matePosition.y);
      arrive(matePosition);
      if ((minMate<10)&&(exo.hunger>exo.htr)) {
        DNA dna_ = new DNA();
        DNA dna1 = dna;
        DNA dna2 = exo.dna;
        if (random(1)<0.5) {
          dna_ = dna1;
        } else {
          dna_ = dna2;
        }
        //mutate
        if (random(1)<0.2) {
          for (int i=0; i<dna_.genes.length; i++) {
            if (random(1)<0.5) {
              dna_.genes[i][0]=random(0, 1);
            }
          }
        }

        PVector l = new PVector(loc.x, loc.y);
        vehicles.add(new Plop(l, dna_));
        println("new: "+(hunger-htr)+" "+(exo.hunger-exo.htr));
        hunger = 2;
        exo.hunger = 2;
      }
    } else {
      nx = map(noise(tx, tz), 0, 1, -0.1, 0.1);
      ny = map(noise(ty, tz), 0, 1, -0.1, 0.1);
      acc.y = ny;
      acc.x = nx;
    }
  }


  void display() {
    colorMode(HSB);
    fill(col, 50, 50);
    noStroke();
    r=map(hunger, 0, 10, 0, 6);
    float theta = vel.heading() + PI/2;
    pushMatrix();
    translate(loc.x, loc.y);
    text(hunger, 0, 0);
    rotate(theta);
    stroke(0);
    strokeWeight(2);
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
    hunger += -0.002;
    tx += 0.1;
    ty += 0.1;
    tz += 0.1;
    timeAlive--;
  }

  void eat(ArrayList<Being> f) {
    for (int i = 0; i<f.size(); i++) {
      Being Mpart = f.get(i);
      PVector foodposition = Mpart.loc;
      float d = PVector.dist(loc, foodposition);

      if (d < r*3) {
        //health += 100; 
        hunger++;
        Mpart.hunger = 0;
      }
    }
  }
  void applyForce(PVector force) {
    acc.add(force);
  }
  void arrive(PVector target) {
    //fill(0);
    //text("eat", loc.x, loc.y+10);
    PVector desired = PVector.sub(target, loc);
    float d = desired.mag();
    desired.normalize();
    if (d < 20) {
      float m = map(d, 0, 20, 0, maxspeed);
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

  
}
