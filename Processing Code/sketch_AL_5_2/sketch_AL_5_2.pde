/*
  This version explores the concept of sharing food. Does sharing food help the 
  community as a whole survive better?
*/

World world;
PFont myFontC;
PFont myFontI;
void setup() {
  size(900, 600, FX2D);
  world = new World(5, 40, 70); //H O P
  myFontC = loadFont("CircularStd-Medium-14.vlw");
  myFontI = loadFont("Inter-Regular-12.vlw");
}

void draw() {
  background(359, 200);
  world.run();
}
