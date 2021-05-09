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
        DNA ndna = part.separate(bg);
        born(part.loc.x, part.loc.y, ndna);
        part.hunger=1;
        //println("new");
      }
      cullBeings();
    }
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
