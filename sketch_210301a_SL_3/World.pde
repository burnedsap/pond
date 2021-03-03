class World {
  ArrayList<Being> bg;
  Food fd;


  World(int b_, int f_) {
    bg = new ArrayList<Being>();
    for (int i=0; i<b_; i++) {
      PVector l = new PVector(random(width), random(height));
      DNA dna = new DNA();
      bg.add(new Being(l, dna));
    }
    fd = new Food(f_);
  }

  void born(float x, float y, DNA dna_) {
    PVector l = new PVector(x, y);
    //dna = dna_;
    bg.add(new Being(l, dna_));
  }

  void run() {
    fd.display();
    for (int i=0; i<bg.size(); i++) {
      Being part = bg.get(i);
      part.control(fd);
      //born();
      //part.separate(bg);
      //part.neutralState();
      part.eat(fd);
      //if (part.hunger<3) {
      //  part.hunt(fd);
      //}
      cullBeings();
      if (part.hunger>5) {
        born(part.loc.x, part.loc.y, part.dna);
        part.hunger=1;
      }
    }
  }

  void cullBeings() {
    for (int i=0; i<bg.size(); i++) {
      Being part = bg.get(i);
      if (part.hunger<=0) {
        bg.remove(i);
        //fd.add(new Food(part.loc.x, part.loc.y));
      }
      if (part.timeAlive >= 1800) {
        bg.remove(i);
        //fd.add(new Food(part.loc.x, part.loc.y));
      }
    }
  }

  //void born() {
  //  for (int i=0; i<bg.size(); i++) {
  //    Being part = bg.get(i);
  //    if (part.hunger>5) {
  //      part.hunger=1;
  //      bg.add(new Being(part.loc.x, part.loc.y));
  //    }
  //  }
  //}
}
