class World {
  ArrayList<Plant> plnt;
  ArrayList<Opus> op;
  ArrayList<Hachi> hc;

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
    for (int i=0; i<plnt.size(); i++) {
      Plant part = plnt.get(i);
      part.run(plnt);
    }
    for (int i=0; i<op.size(); i++) {
      Opus part = op.get(i);
      part.run(plnt, op);
    }
    for (int i=0; i<hc.size(); i++) {
      Hachi part = hc.get(i);
      part.run(op, hc);
    }
  }
}
