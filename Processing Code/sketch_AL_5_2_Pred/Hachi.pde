/*
3rd in food chain
Eats Opus
*/
class Hachi {
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
  DNA dna;
  float r;
  //DNA Metrics
  //colour


  Hachi(PVector l, DNA dna_) {
    dna = dna_;
    maxspeed = map(dna.genes[0][0], 0, 1, HachiSpeedMin, HachiSpeedMax); //maximum speed
    hmaxspeed = maxspeed+1; //sets higher version of maxspeed when really hungry
    vision = map(dna.genes[1][0], 0, 1, HachiVisionMin, HachiVisionMax); //radius of how much it can 'sense' around it
    reproduce = map(dna.genes[2][0], 0, 1, HachiHtrMin, HachiHtrMax); //amount of food needed before it can reproduce
    age = map(dna.genes[3][0], 0, 1, HachiAgeMin, HachiAgeMax); //how long does it naturally live for
    hunger = map(dna.genes[4][0], 0, 1, HachiHungerMin, HachiHungerMax); //how much food is it born with
    col = map(dna.genes[0][0], 0, 1, 0, 359); //colour mapped to maximum speed

    //each being is basically a vector
    loc = new PVector(l.x, l.y);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);

    px = loc.x;
    py = loc.y;
    
    //turning speed
    maxforce = 0.1;
    
    //initial radius of being, but immediately resets to how much food it has
    r = 1;
    
    //noise variables for random movement
    tx = random(100);
    ty = random(10000);
    tz = random(10);
  }
  void run(ArrayList<Opus> o, ArrayList<Hachi> h) { //takes in arrays of Opus (food) and fellow Hachi
    update(o);
    cull(h);
    
    //finds location of all Opus (food) 
    FloatList opusDistance = new FloatList();
    for (int i = 0; i<o.size(); i++) {
      Opus part = o.get(i);
      PVector opusPosition = part.loc;
      float d = PVector.dist(loc, opusPosition);
      opusDistance.append(d);
    }
    float minOpusVal = vision+10;
    PVector opusPosition = new PVector();
    float opusSize = 1000;
    if (opusDistance.size()>0) {
      minOpusVal = opusDistance.min();
      int opusTemp = opusDistance.index(minOpusVal);
      opusPosition = o.get(opusTemp).loc;
      opusSize = o.get(opusTemp).r;
    }

    //finds location of all Hachi
    FloatList hachiDistance = new FloatList();
    for (int i = 0; i<h.size(); i++) {
      Hachi part = h.get(i);
      float d = PVector.dist(loc, part.loc);
      if ((d==0.0)) {
        hachiDistance.append(1000);
      } else {
        hachiDistance.append(d);
      }
    }
    float minHachiVal = vision+10;
    PVector hachiPosition = new PVector();
    PVector ltemp = new PVector(random(width), random(height));
    DNA dnatemp = new DNA();
    Hachi exo = new Hachi(ltemp, dnatemp);
    if (hachiDistance.size()>0) {
      minHachiVal= hachiDistance.min();
      int hachiTemp = hachiDistance.index(minHachiVal);
      exo = h.get(hachiTemp);
      hachiPosition = h.get(hachiTemp).loc;
    } 
    
    //Controllers (switches between active states based on set parameters (b/w looking for food, mates, or just randomly moving around
    //if ((minOpusVal<vision)&&(hunger<4)&&(opusSize<r*1.2)) { //hunt for food within its 'vision' and if food isn't too much bigger than it
      if ((minOpusVal<vision)&&(hunger<4)) {
      stroke(309, 100);
      line(loc.x, loc.y, opusPosition.x, opusPosition.y);
      arrive(opusPosition);
    } else if ((minHachiVal<vision)&&(hunger>reproduce)&&(exo.hunger>exo.reproduce)) { //if ready, look for eligible mates
      stroke(309, 100);
      line(loc.x, loc.y, hachiPosition.x, hachiPosition.y);
      arrive(hachiPosition);
      if ((minHachiVal<10)&&(exo.hunger>exo.reproduce)) { //if mate found, swap genes with DNA
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
        h.add(new Hachi(l, dna_));
        //println("new: "+(hunger-htr)+" "+(exo.hunger-exo.htr));
        hunger = 2;
        exo.hunger = 2;
      }
    } else { //if nothing matches above states, randomly move around
      nx = map(noise(tx, tz), 0, 1, -0.1, 0.1);
      ny = map(noise(ty, tz), 0, 1, -0.1, 0.1);
      acc.y = ny;
      acc.x = nx;
    }
  }

  void cull(ArrayList<Hachi> h) { //killing mechanism-either of old age, or of hunger
    for (int i = 0; i<h.size(); i++) {
      Hachi part = h.get(i);
      if (part.hunger<0) {
        h.remove(i);
        println("Hachi Food Death");
        //p.add(new Plant());
      }
      if (part.age<0) {
        h.remove(i);
         println("Hachi Age Death");
        //p.add(new Plant());
      }
    }
  }


  void display() { //displays stuff
    colorMode(HSB, 360, 100, 100);
    fill(0);
    noStroke();
    r = map(hunger, 0, 10, 0, 8);
    float theta = vel.heading() + PI/2;
    pushMatrix();
    translate(loc.x, loc.y);
    //text(hunger, 0, 0);
    rotate(theta);
    beginShape();
    stroke(255);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
  void update(ArrayList<Opus> p) { //consolidates everything to keep it smooth and moving
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

  void eat(ArrayList<Opus> o) { //eating engine
    for (int i = 0; i<o.size(); i++) {
      Opus part = o.get(i);
      PVector foodposition = part.loc;
      float d = PVector.dist(loc, foodposition);

      if (d < r*3) {
        hunger++;
        o.remove(i);
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
    steer.limit(maxforce);
    applyForce(steer);
  }
}
