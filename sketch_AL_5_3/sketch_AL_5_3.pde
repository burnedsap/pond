/*
This version adds food conservation intelligence
*/

World world;
PFont myFontC;
PFont myFontI;
void setup() {
  size(900, 600, FX2D);
  frameRate(40);
  world = new World(5, 40, 70); //H O P
  myFontC = loadFont("CircularStd-Medium-14.vlw");
  myFontI = loadFont("Inter-Regular-12.vlw");
}

void draw() {
  background(359, 200);
  world.run();
}
