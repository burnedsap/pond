class Food {
  PVector loc;


  Food(float _x, float _y) {
    loc = new PVector(_x, _y);
  }

  void display() {
    fill(255);
    ellipse(loc.x, loc.y, 10, 10);
  }
   void eaten() {
     fill(50);
    ellipse(loc.x, loc.y, 10, 10);
  }
}
