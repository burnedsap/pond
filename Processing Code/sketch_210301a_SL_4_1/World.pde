class World {
  ArrayList<Being> bg;
  Food fd;


  World(int b_, int f_) {
    bg = new ArrayList<Being>();
    //Create Beings
    for (int i=0; i<b_; i++) {
      PVector l = new PVector(random(width), random(height));
      DNA dna = new DNA();
      bg.add(new Being(l, dna));
    }
    //Create initial pool of food
    fd = new Food(f_);
  }


  void run() {
    //Display food
    fd.display();

    for (int i=0; i<bg.size(); i++) {
      Being part = bg.get(i);

      //Run central command for Being
      part.control(fd);
      //part.separate(bg);


      //Create new Beings when they have eaten enough
      if (part.hunger>5) {
        DNA ndna = checkMate(part); 
        //DNA ndna = part.separate(bg);
        born(part.loc.x, part.loc.y, ndna);
        part.hunger=1;
        //println("new");
      }
      cullBeings();
    }
  }

  DNA checkMate(Being sub) {
    float desiredseparation = sub.r*5;
    DNA dna_1 = sub.dna;
    DNA dna_2 = new DNA();
    DNA dna_3 = new DNA();
    for (Being other : bg) {
      float d = PVector.dist(sub.loc, other.loc);
      if ((d > 0) && (d < desiredseparation)) {
        dna_2 = other.dna;
      }
    }
    if(random(1)<0.5) {
     dna_3.genes[0][0] = dna_1.genes[0][0]; 
    }
    else {
      dna_3.genes[0][0] = dna_2.genes[0][0]; 
    }
    if(random(1)<0.5) {
     dna_3.genes[1][0] = dna_1.genes[1][0]; 
    }
    else {
      dna_3.genes[1][0] = dna_2.genes[1][0]; 
    }
    return dna_3;
  }

  //Create new beings with given DNA
  void born(float x, float y, DNA dna_) {
    PVector l = new PVector(x, y);
    bg.add(new Being(l, dna_));
  }

  //Remove Beings when they no food or live for a certain period of time
  void cullBeings() {
    for (int i=0; i<bg.size(); i++) {
      Being part = bg.get(i);
      if (part.hunger<=0) {
        bg.remove(i);
      }
      if (part.timeAlive >= 1800) {
        bg.remove(i);
      }
    }
  }
}
