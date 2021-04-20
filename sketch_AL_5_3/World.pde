class World {
  ArrayList<Plant> plnt;
  ArrayList<Opus> op;
  ArrayList<Hachi> hc;
  float OpusAvgSpeed = 0;
  float OpusAvgHtr = 0;
  float OpusAvgVision = 0;
  float OpusAvgAge = 0;
  float HachiAvgSpeed = 0;
  float HachiAvgHtr = 0;
  float HachiAvgVision = 0;
  float HachiAvgAge = 0;


  World(int h_, int o_, int p_) {
    plnt = new ArrayList<Plant>();
    for (int i=0; i<p_; i++) {
      plnt.add(new Plant());
    }
    op = new ArrayList<Opus>();
    for (int i=0; i<o_; i++) {
      PVector l = new PVector(random(width), random(height));
      DNA dna = new DNA();
      op.add(new Opus(l, dna));
    }
    hc = new ArrayList<Hachi>();
    for (int i=0; i<h_; i++) {
      PVector l = new PVector(random(width), random(height));
      DNA dna = new DNA();
      hc.add(new Hachi(l, dna));
    }
  }

  void run() {
    //Stats Display
    textSize(14);
    fill(0);
    textFont(myFontC);
    text("Hachi: "+hc.size(), 360, height-60);
    text("Opus: "+op.size(), 10, height-60);

    textFont(myFontI);
    textSize(12);

    text("Speed", 10, height-40);
    text("Rpdc", 60, height-40);
    text("Vision", 110, height-40);
    text("Age", 160, height-40);
    text(OpusAvgSpeed/op.size(), 10, height-23);
    text(OpusAvgHtr/op.size(), 60, height-23);
    text(OpusAvgVision/op.size(), 110, height-23);
    text(OpusAvgAge/op.size(), 160, height-23);
    OpusAvgSpeed = 0;
    OpusAvgHtr = 0;
    OpusAvgVision = 0;
    OpusAvgAge = 0;

    text("Speed", 360, height-40);
    text("Rpdc", 410, height-40);
    text("Vision", 460, height-40);
    text("Age", 510, height-40);
    text(HachiAvgSpeed/hc.size(), 360, height-23);
    text(HachiAvgHtr/hc.size(), 410, height-23);
    text(HachiAvgVision/hc.size(), 460, height-23);
    text(HachiAvgAge/hc.size(), 510, height-23);
    HachiAvgSpeed = 0;
    HachiAvgHtr = 0;
    HachiAvgVision = 0;
    HachiAvgAge = 0;

    for (int i=0; i<plnt.size(); i++) {
      Plant part = plnt.get(i);
      part.run(plnt);
    }
    for (int i=0; i<op.size(); i++) {
      Opus part = op.get(i);
      part.run(plnt, op);

      OpusAvgSpeed += map(part.dna.genes[0][0], 0, 1, 1, 5);
      OpusAvgHtr += map(part.dna.genes[2][0], 0, 1, 2, 7);
      OpusAvgVision += map(part.dna.genes[1][0], 0, 1, 20, 120);
      OpusAvgAge += map(part.dna.genes[3][0], 0, 1, 2000/frameRate, 6000/frameRate);
    }
    for (int i=0; i<hc.size(); i++) {
      Hachi part = hc.get(i);
      part.run(op, hc);

      HachiAvgSpeed += map(part.dna.genes[0][0], 0, 1, 1, 4);
      HachiAvgHtr += map(part.dna.genes[2][0], 0, 1, 4, 7);
      HachiAvgVision += map(part.dna.genes[1][0], 0, 1, 20, 100);
      HachiAvgAge += map(part.dna.genes[3][0], 0, 1, 2000/frameRate, 6000/frameRate);
    }
  }
}
