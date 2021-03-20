class World {
  ArrayList<Being> bg;
  Food fd;
  boolean FoodCheck = false;
  int deadCounter = 0;
  float avgSpeed = 0;
  float avgHtr = 0;
  

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
    text(avgSpeed/bg.size(), 10, 50);
    text(avgHtr/bg.size(), 10, 30);
    avgSpeed = 0;
    avgHtr = 0;
    for (int i=0; i<bg.size(); i++) {
      Being part = bg.get(i);
      avgSpeed += map(part.dna.genes[1][0], 0, 1, 1, 4);
      avgHtr += map(part.dna.genes[0][0], 0, 1, 2, 6);
      part.disp(fd);

      //Food Distance
      float fooDist = 0;
      PVector target = new PVector();
      ArrayList<PVector> food = fd.getFood();
      //for (int j = food.size()-1; j >= 0; j--) {
      ////for (int j =0; j< food.size(); j++) {
      //  PVector foodposition = food.get(j);
      //  fooDist = PVector.dist(part.loc, foodposition);
      //  //if ((fooDist>0)&&(fooDist<100)) {
      //    target = foodposition;
      //    //FoodCheck = true;
      //    //stroke(51, 50);
      //    //line(part.loc.x, part.loc.y, foodposition.x, foodposition.y);
      //  //}
      //  //else {
      //    //FoodCheck = false;
      //  //}
      //  //target = foodposition;
      //}

      //Mate Distance
      int MpartO = 0;
      float mateDist = 0;
      PVector Mtarget = new PVector();
      //ArrayList<PVector> food = fd.getFood();
      for (int j = bg.size()-1; j >= 0; j--) {
        Being Mpart = bg.get(j);
        if (Mpart.hunger>4) {
          MpartO = j;
          PVector mateposition = Mpart.loc;
          mateDist = PVector.dist(part.loc, mateposition);
          Mtarget = mateposition;
        }
      }
      part.hunt(fd, bg);
      //} else if ((mateDist>0)&&(mateDist<100) && (part.hunger>4)) {
      //  fill(255, 0, 0);
      //  text("mate", part.loc.x, part.loc.y+12);        
      //  part.maxspeed = 1;
      //  part.arrive(Mtarget);
      //  if ((mateDist>0)&&(mateDist<20)) {
      //    DNA dna_ = new DNA();
      //    born(part.loc.x, part.loc.y, dna_);
      //    part.hunger = 2;
      //    bg.get(MpartO).hunger = 2;
      //  }
      //} else {
      //  part.neutral();
      //}
      //Run central command for Being
      //part.control(fd);
      //part.hunt(fd, bg);
      //part.separate(bg);
      //if (part.hunger > 4) {
      //  if (part.intersect(bg)) {
      //    DNA dna_ = new DNA();
      //    born(part.loc.x, part.loc.y, dna_);
      //    part.hunger = 3;
      //  }
      //}
      //Create new Beings when they have eaten enough

      //for (int j=0; j<bg.size(); j++) {
      //  Being Opart = bg.get(j);
      //  if (part.intersect(Opart) == true) {
      //    println("intersext");
      //    DNA dna_ = new DNA();
      //    born(part.loc.x, part.loc.y, dna_);
      //  }
      //}
      //  DNA ndna = checkMate(part); 
      //  //DNA ndna = part.separate(bg);
      //  born(part.loc.x, part.loc.y, ndna);
      //  part.hunger=1;
      //  //println("new");

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
    if (random(1)<0.5) {
      dna_3.genes[0][0] = dna_1.genes[0][0];
    } else {
      dna_3.genes[0][0] = dna_2.genes[0][0];
    }
    if (random(1)<0.5) {
      dna_3.genes[1][0] = dna_1.genes[1][0];
    } else {
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
        fd.add(part.loc);
        deadCounter++;
        println("food dead: "+deadCounter);
      }
      if (part.timeAlive <1) {
        bg.remove(i);
        fd.add(part.loc);
        deadCounter++;
        println("time dead: "+deadCounter);
      }
    }
  }
  //void mateDist(Being ex, ArrayList<Being> vehicles) {
  //  PVector matex = ex.loc.copy();
  //  for (int i=0; i<vehicles.size(); i++) {
  //    Being part = vehicles.get(i);
  //    PVector mateposition = part.loc.copy();
  //    float d = PVector.dist(matex, mateposition);
  //    if ((d<50) && (ex.hunger<5)&& (part.hunger<5)) {
  //      //mating();
  //    }
  //  }
  //}
}
