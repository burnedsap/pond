/*
  This version adds food conservation intelligence
  look at precedents-scientific studies
  programmatic computer itnelligence studies
  look wat thwat has been explained
  look for advice-justin bakse maybe?
  start writing experiences
  Ecosystem executed on a visually appealing
  Research more questions–breif survery of the field
  what questions have been asked, concluded?, any open qeustions
  Ecology and technical side of things
  DT tutor
  Original ecosystem-find flaw
  share food that hasn't been eaten
  Do more research
  
  Refs:
  evolution of altruism
  evolution of generational knowledge
  evolution of communication
  Eusociality
  Vulnerable Ape Hypothesis
  Evolution of emotional intelligence
  Maybe make a paper?
  Look at numbers in their code
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
