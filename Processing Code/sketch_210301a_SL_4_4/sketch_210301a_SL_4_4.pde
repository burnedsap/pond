World world; //<>//
void setup() {
  size(800, 600, FX2D);
  world = new World(4, 30, 100);
}

void draw() {
  background(240);
  world.run();
}

void mousePressed() {
  DNA dna = new DNA();
  //world.born(mouseX, mouseY, dna);
}
