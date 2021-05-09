/*
  This is the standard version, to be benchmarked against others
*/
World world;
PFont myFontC;
PFont myFontI;
void setup() {
  size(900, 600, FX2D);
  
  //All objects living within a 'World'
  world = new World(15, 40, 70); //refers to number of Hachi(3rd in food chain) Opus(2nd in food chain) Plants on start
  
  //load in custom fonts
  myFontC = loadFont("CircularStd-Medium-14.vlw");
  myFontI = loadFont("Inter-Regular-12.vlw");
}

void draw() {
  background(359, 200);
  world.run();
}
