World world; //<>//
void setup() {
  size(600, 400);
  rectMode(CENTER);
  world = new World(2, 10);
}

void draw() {
  background(240);
  world.run();
}

void mousePressed() {
  //world.born(mouseX,mouseY);
}

void mouseDragged() {
  //world.born(mouseX,mouseY);
}



//    //multiply
//    if (part.hunger>4) {
//      part.hunger=1;
//      bg.add(new Being(part.loc.x, part.loc.y));
//    }
//  }
