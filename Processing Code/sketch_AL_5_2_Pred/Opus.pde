/*
2nd in food chain
 Eats Food
 Eaten by Opus
 
 //add plant reproduce limit
 */
class Opus {
  PVector loc;
  PVector vel;
  PVector acc;
  float tx, ty, tz;
  float px, py;
  float maxforce;
  float maxspeed, vision, reproduce, age, col;
  float hmaxspeed;
  float hunger;
  float nx, ny = 0.0;
  float share;
  float foodsafe;
  DNA dna;
  float r;
  //DNA Metrics
  //colour


  Opus(PVector l, DNA dna_) {
    dna = dna_;
    maxspeed = map(dna.genes[0][0], 0, 1, OpusSpeedMin, OpusSpeedMax); //maximum speed
    hmaxspeed = maxspeed+1; //sets higher version of maxspeed when really hungry
    vision = map(dna.genes[1][0], 0, 1, OpusVisionMax, OpusVisionMax); //radius of how much it can 'sense' around it
    reproduce = map(dna.genes[2][0], 0, 1, OpusHtrMin, OpusHtrMax); //amount of food needed before it can reproduce
    age = map(dna.genes[3][0], 0, 1, OpusAgeMin, OpusAgeMax); //how long does it naturally live for
    hunger = map(dna.genes[4][0], 0, 1, OpusHungerMin, OpusHungerMax); //how much food is it born with
    col = map(dna.genes[0][0], 0, 1, 0, 127); //colour mapped to maximum speed
    share = map(dna.genes[5][0], 0, 1, 0, 1);//sharing gene
    foodsafe = map(dna.genes[6][0], 0, 1, 0, 1);


    loc = new PVector(l.x, l.y);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);

    px = loc.x;
    py = loc.y;

    maxforce = 0.3;
    r = 1;
    //timeAlive=random(4000, 5000);

    tx = random(100);
    ty = random(10000);
    tz = random(10);
  }
  void run(ArrayList<Plant> p, ArrayList<Opus> o, ArrayList<Hachi> h) {
    update(p);
    cull(o, p);

    FloatList hachiDistance = new FloatList();
    for (int i = 0; i<h.size(); i++) {
      Hachi part = h.get(i);
      PVector hachiposition = part.loc;
      float d = PVector.dist(loc, hachiposition);
      hachiDistance.append(d);
    }

    float minHachiVal = vision+10;
    PVector lhtemp = new PVector(random(width), random(height));
    PVector hachiPosition = new PVector();

    if (hachiDistance.size()>0) {
      minHachiVal = hachiDistance.min();
      int hachiTemp = hachiDistance.index(minHachiVal);
      hachiPosition = h.get(hachiTemp).loc;
    }



    FloatList plantDistance = new FloatList();
    for (int i = 0; i<p.size(); i++) {
      Plant part = p.get(i);
      PVector foodposition = part.loc;
      float d = PVector.dist(loc, foodposition);
      plantDistance.append(d);
    }
    float minPlantVal = plantDistance.min();
    int plantTemp = plantDistance.index(minPlantVal);
    PVector plantPosition = p.get(plantTemp).loc;
    float plantSize = p.get(plantTemp).r;

    FloatList opusDistance = new FloatList();
    for (int i = 0; i<o.size(); i++) {
      Opus part = o.get(i);
      float d = PVector.dist(loc, part.loc);
      if ((d==0.0)) {
        opusDistance.append(1000);
      } else {
        opusDistance.append(d);
      }
    }

    float minOpusVal = vision+10;
    PVector ltemp = new PVector(random(width), random(height));
    DNA dnatemp = new DNA();
    Opus exo = new Opus(ltemp, dnatemp);
    PVector opusPosition = new PVector();
    if (opusDistance.size()>0) {
      minOpusVal = opusDistance.min();
      int opusTemp = opusDistance.index(minOpusVal);
      exo = o.get(opusTemp);
      opusPosition = o.get(opusTemp).loc;
    }


    //Controllers
    //if ((minPlantVal<vision)&&(hunger<4)&&(plantSize<r*6)) {
    if ((minOpusVal<r*2)&&(hunger>reproduce)&&(hunger>exo.hunger)&&(exo.hunger<exo.reproduce)&&(share>OpusShare)&&(exo.share>OpusShare)) {
      println("Shared");
      hunger--;
      exo.hunger++;
    }
    if (minHachiVal<r*10) {
      stroke(255, 0, 0);
      line(loc.x, loc.y, hachiPosition.x, hachiPosition.y);
      escape(hachiPosition);
    }
    if ((minPlantVal<vision)&&(hunger<4)) {
      if (foodsafe > OpusCare) {
        if (plantSize>6) {
          stroke(359, 100);
          line(loc.x, loc.y, plantPosition.x, plantPosition.y);
          arrive(plantPosition);
        } else {
          neutral();
        }
      } else {
        stroke(359, 100);
        line(loc.x, loc.y, plantPosition.x, plantPosition.y);
        arrive(plantPosition);
      }
      //stroke(359, 100);
      //line(loc.x, loc.y, plantPosition.x, plantPosition.y);
      //arrive(plantPosition);
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
        o.add(new Opus(l, dna_));
        //println("new: "+(hunger-htr)+" "+(exo.hunger-exo.htr));
        hunger = 2;
        exo.hunger = 2;
      }
    } else {
      neutral();
    }
  }

  //end of controller section

  void neutral() {
    nx = map(noise(tx, tz), 0, 1, -0.1, 0.1);
    ny = map(noise(ty, tz), 0, 1, -0.1, 0.1);
    acc.y = ny;
    acc.x = nx;
  }

  void cull(ArrayList<Opus> o, ArrayList<Plant> p) { //killing mechanism-either of old age, or of hunger
    for (int i = 0; i<o.size(); i++) {
      Opus part = o.get(i);
      if (part.hunger<0) {
        o.remove(i);
        println("Opus Hunger Death");
        p.add(new Plant());
      }
      if (part.age<0) {
        o.remove(i);
        println("Opus Age Death");
        p.add(new Plant());
      }
    }
  }


  void display() { //displays stuff
    colorMode(HSB, 360, 100, 100);
    fill(col, 70, 70);
    noStroke();
    r = map(hunger, 0, 10, 0, 8);
    float theta = vel.heading() + PI/2;
    pushMatrix();
    translate(loc.x, loc.y);
    //text(vel.mag(), 0, 0);
    rotate(theta);
    beginShape();
    noStroke();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
  void update(ArrayList<Plant> p) { //consolidates everything to keep it smooth and moving
    wall();
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);

    if (hunger<1) {
      maxspeed=hmaxspeed;
    }
    //hunger += -0.001;
    hunger += map(vel.mag(), 0, maxspeed, -0.001, -0.005);

    tx += 0.1;
    ty += 0.1;
    tz += 0.1;

    age--;
    if (hunger<10) {
      eat(p);
    }
    display();
  }

  void eat(ArrayList<Plant> p) { //eating engine
    for (int i = 0; i<p.size(); i++) {
      Plant part = p.get(i);
      PVector foodposition = part.loc;
      float d = PVector.dist(loc, foodposition);
      float pSize = part.r;
      //if ((d < r*3)&&(hunger<10)&&(hunger>2)) {
      if ((d < r*3)&&(hunger<10)) {
        if ((foodsafe > OpusCare)&&(hunger>2)) {
          if (part.r>6) {
            hunger+=map(pSize, 1, 10, 1, 3);
            p.remove(i);
          }
        } else {
          hunger+=map(pSize, 1, 10, 1, 3);
          p.remove(i);
        }
      }
    }
  }

  void applyForce(PVector force) { //ehh boring bit dont touch
    acc.add(force);
  }
  void arrive(PVector target) { //provides a nice easing approach to target (food or mate)
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

  void escape(PVector target) { //provides a nice easing approach to target (food or mate)
    PVector desired = PVector.sub(target, loc);
    float d = desired.mag();
    desired.normalize();
    if (d < 20) {
      float m = map(d, 0, 20, 0, maxspeed);
      desired.mult(m*-1);
    } else {
      desired.mult(maxspeed*-1);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce+2);
    applyForce(steer);
  }

  void wall() { //keeps everyone within boundaries
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
    steer.limit(maxforce+1);
    applyForce(steer);
  }
}
