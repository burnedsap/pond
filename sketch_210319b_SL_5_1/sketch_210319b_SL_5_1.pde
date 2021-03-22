World world;
PFont myFontC;
PFont myFontI;
void setup() {
  size(900, 600, FX2D);
  world = new World(15, 40, 70);
  myFontC = loadFont("CircularStd-Medium-14.vlw");
  myFontI = loadFont("Inter-Regular-12.vlw");
}

void draw() {
  background(359, 200);
  world.run();
}
