class Hachi {
  PVector loc;
  PVector vel;
  PVector acc;
  float tx, ty, tz;
  float px, py;
  float maxforce;
  float maxspeed, vision, reproduce, age, col;
  float hunger;
  float nx, ny = 0.0;
  DNA dna;
  float r;
  //DNA Metrics
  //colour


  Hachi(PVector l, DNA dna_) {
    dna = dna_;
    maxspeed = map(dna.genes[0][0], 0, 1, 1, 4);
    vision = map(dna.genes[1][0], 0, 1, 20, 80);
    reproduce = map(dna.genes[2][0], 0, 1, 4, 7);
    age = map(dna.genes[3][0], 0, 1, 2000, 6000);
    hunger = map(dna.genes[4][0], 0, 1, 1, 4);
    col = map(dna.genes[0][0], 0, 1, 217, 359);

    loc = new PVector(l.x, l.y);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);

    px = loc.x;
    py = loc.y;

    maxforce = 0.1;
    r = 1;
    //timeAlive=random(4000, 5000);

    tx = random(100);
    ty = random(10000);
    tz = random(10);
  }
  void run(ArrayList<Opus> p, ArrayList<Hachi> o) {
    update(p);
    cull(o);

    FloatList plantDistance = new FloatList();
    for (int i = 0; i<p.size(); i++) {
      Opus part = p.get(i);
      PVector foodposition = part.loc;
      float d = PVector.dist(loc, foodposition);
      plantDistance.append(d);
    }
    float minPlantVal = plantDistance.min();
    int plantTemp = plantDistance.index(minPlantVal);
    PVector plantPosition = p.get(plantTemp).loc;

    FloatList opusDistance = new FloatList();
    for (int i = 0; i<o.size(); i++) {
      Hachi part = o.get(i);
      float d = PVector.dist(loc, part.loc);
      if ((d==0.0)) {
        opusDistance.append(1000);
      } else {
        opusDistance.append(d);
      }
    }
    float minOpusVal= opusDistance.min();
    int opusTemp = opusDistance.index(minOpusVal);
    Hachi exo = o.get(opusTemp);
    PVector opusPosition = o.get(opusTemp).loc;

    //Controllers
    if ((minPlantVal<vision)&&(hunger<4)) {
      stroke(359, 100);
      line(loc.x, loc.y, plantPosition.x, plantPosition.y);
      arrive(plantPosition);
    } else if ((minOpusVal<vision)&&(hunger>reproduce)&&(exo.hunger>exo.reproduce)) {
      stroke(359, 100);
      line(loc.x, loc.y, opusPosition.x, opusPosition.y);
      arrive(opusPosition);
      if ((minOpusVal<10)&&(exo.hunger>exo.reproduce)) {
        DNA dna_ = new DNA();
        for (int i=0; i<dna_.genes.length; i++) {
          if (random(1)<0.5) {
            dna_.genes[i][0]=dna.genes[i][0];
          } else {
            dna_.genes[i][0]=exo.dna.genes[i][0];
          }
        }
        if (random(1)<0.2) {
          for (int i=0; i<dna_.genes.length; i++) {
            if (random(1)<0.5) {
              dna_.genes[i][0] += random(-0.01, 0.01);
            }
          }
        }

        PVector l = new PVector(loc.x, loc.y);
        o.add(new Hachi(l, dna_));
        //println("new: "+(hunger-htr)+" "+(exo.hunger-exo.htr));
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

  void cull(ArrayList<Hachi> o) {
    for (int i = 0; i<o.size(); i++) {
      Hachi part = o.get(i);
      if(part.hunger<0){
       o.remove(i);
       //p.add(new Plant());
      }
      if(part.age<0) {
       o.remove(i);
       //p.add(new Plant());
      }
    }
  }


  void display() {
    colorMode(HSB, 360, 100, 100);
    fill(col, 70, 70);
    noStroke();
    r = map(hunger, 0, 10, 0, 8);
    float theta = vel.heading() + PI/2;
    pushMatrix();
    translate(loc.x, loc.y);
    //text(hunger, 0, 0);
    rotate(theta);
    beginShape();
    noStroke();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
  void update(ArrayList<Opus> p) {
    wall();
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);
    hunger += -0.001;

    tx += 0.1;
    ty += 0.1;
    tz += 0.1;

    age--;
    if (hunger<10) {
      eat(p);
    }
    display();
  }

  void eat(ArrayList<Opus> p) {
    for (int i = 0; i<p.size(); i++) {
      Opus part = p.get(i);
      PVector foodposition = part.loc;
      float d = PVector.dist(loc, foodposition);

      if (d < r*3) {
        hunger++;
        p.remove(i);
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
