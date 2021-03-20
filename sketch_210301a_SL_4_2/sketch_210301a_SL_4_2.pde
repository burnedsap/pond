World world; //<>//
void setup() {
  size(600, 400, FX2D);
  world = new World(20, 70);
}

void draw() {
  background(240);
  world.run();
}

void mousePressed() {
  DNA dna = new DNA();
  world.born(mouseX, mouseY, dna);
}
