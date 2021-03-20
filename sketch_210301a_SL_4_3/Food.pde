class Food {
  ArrayList<PVector> food;
  float fs;

  Food(int num) {
    food = new ArrayList();
    for (int i=0; i<num; i++) {
      food.add(new PVector(random(width), random(height)));
    }

    fs = 1;
  }

  void display() {
    fill(255);
    for (PVector f : food) {
      //float tx = random(100);
      //float ty = random(100);
      //float tz = random(100);
      //float px = map(noise(tx, tz), 0, 1, -fs, fs);
      //float py = map(noise(ty, tz), 0, 1, -fs, fs);
      //PVector velocity = new PVector(px, py);

      //tx += 0.01;
      //ty += 0.01;
      //tz += 0.01;
      //f.add(velocity);

      ellipse(f.x, f.y, 10, 10);
    }
    if (random(1) < 0.01) {
      food.add(new PVector(random(width), random(height)));
    }
    
    if (food.size()<4) {
      food.add(new PVector(random(width), random(height)));
    }
  }
  void add(PVector l) {
    food.add(l.copy());
  }
  ArrayList getFood() {
    return food;
  }
}
