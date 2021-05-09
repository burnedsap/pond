class World {
  ArrayList<Being> bg;
  ArrayList<Plop> pl;
  Food fd;
  boolean FoodCheck = false;
  int deadCounter = 0;
  float avgSpeed = 0;
  float avgHtr = 0;
  

  World(int p_, int b_, int f_) {
    bg = new ArrayList<Being>();
    pl= new ArrayList<Plop>();
    //Create Beings
    for (int i=0; i<b_; i++) {
      PVector l = new PVector(random(width), random(height));
      DNA dna = new DNA();
      bg.add(new Being(l, dna));
    }
    for (int j=0; j<p_; j++) {
      PVector l = new PVector(random(width), random(height));
      DNA dna = new DNA();
      pl.add(new Plop(l, dna));
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
      part.hunt(fd, bg);
      cullBeings();
    }
    for (int i=0; i<pl.size(); i++) {
      Plop part = pl.get(i);
      part.disp(bg);
      part.hunt(bg, pl);
      PLcullBeings();
    }
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
    void PLcullBeings() {
    for (int i=0; i<pl.size(); i++) {
      Plop part = pl.get(i);
      if (part.hunger<=0) {
        pl.remove(i);
        fd.add(part.loc);
        deadCounter++;
        println("food dead: "+deadCounter);
      }
      if (part.timeAlive <1) {
        pl.remove(i);
        fd.add(part.loc);
        deadCounter++;
        println("time dead: "+deadCounter);
      }
    }
  }
}
