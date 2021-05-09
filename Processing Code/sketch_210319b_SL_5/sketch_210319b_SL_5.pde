World world;
void setup() {
  size(600, 400, FX2D);
  world = new World(3, 15, 30);
}

void draw() {
  background(0);
  world.run();
}
