/*
  This is the standard version which includes controls to enable Sharing and Environment Centered Survival
 */
//Secondary Window
import controlP5.*;
ChildApplet child;
ControlP5 cp5;
World world;
int myColorBackground = color(0, 0, 0);
int colorMin = 100;
int colorMax = 100;
Range range;

PFont myFontC;
PFont myFontI;
int timer;
float totalTime = 0;
FloatList OpusN = new FloatList();
FloatList HachiN = new FloatList();
FloatList PlantN = new FloatList();

//Variable List
int numberPlant = 70;
int numberOpus = 50;
int numberHachi = 20;

//Hachi
float HachiAgeMin = 3000;
float HachiAgeMax = 8000;
float HachiHtrMin = 5;
float HachiHtrMax = 9;
float HachiHungerMin = 2;
float HachiHungerMax = 5;
float HachiVisionMin = 20;
float HachiVisionMax = 90;
float HachiSpeedMin = 1;
float HachiSpeedMax = 3;

//Opus
float OpusAgeMin = 2000;
float OpusAgeMax = 6000;
float OpusHtrMin = 2;
float OpusHtrMax = 7;
float OpusHungerMin = 2;
float OpusHungerMax = 4;
float OpusVisionMin = 30;
float OpusVisionMax = 120;
float OpusSpeedMin = 2;
float OpusSpeedMax = 5;
float OpusShare = 1; //change to 0.5 to enable sharing
float OpusCare = 1; //change to 0.5 to enable sharing (pref 0.1)

//Plant
float minPlantVal = 10;
float PlantRegenVal = 0.1;
float maxPlantVal = 100;

void setup() {
  size(1000, 860, FX2D);
  surface.setTitle("Main sketch");
  child = new ChildApplet();

  //All objects living within a 'World'
  world = new World(20, 50, 70); //refers to number of Hachi(3rd in food chain) Opus(2nd in food chain) Plants on start

  //load in custom fonts
  myFontC = loadFont("CircularStd-Medium-14.vlw");
  myFontI = loadFont("Inter-Regular-12.vlw");
}

void draw() {
  background(237, 84, 8);
  //totalTime += millis()/1000;
  if (world != null) {
    world.run();

    if (millis() - timer >= 200) {
    //  TableRow newRow = table.addRow();
    //  newRow.setInt("opus-number", world.op.size());
    //  newRow.setFloat("opus-avg-speed", world.OpusAvgSpeed/world.op.size());
    //  newRow.setFloat("opus-avg-vision", world.OpusAvgVision/world.op.size());
    //  newRow.setFloat("opus-avg-htr", world.OpusAvgHtr/world.op.size());
    //  newRow.setFloat("opus-avg-age", world.OpusAvgAge/world.op.size());
    //  newRow.setInt("hachi-number", world.hc.size());
    //  newRow.setFloat("hachi-avg-speed", world.HachiAvgSpeed/world.hc.size());
    //  newRow.setFloat("hachi-avg-vision", world.HachiAvgVision/world.hc.size());
    //  newRow.setFloat("hachi-avg-htr", world.HachiAvgHtr/world.hc.size());
    //  newRow.setFloat("hachi-avg-age", world.HachiAvgAge/world.hc.size());
    //  newRow.setInt("plant-number", world.plnt.size());
      OpusN.append(world.op.size());
      HachiN.append(world.hc.size());
      PlantN.append(world.plnt.size());
      //totalTime += 1;
      timer = millis();
    }

    noFill();
    stroke(280);
    beginShape();
    for (int i = 0; i < OpusN.size(); i++) {
      float y = map(OpusN.get(i), 0, 200, height-10, height-110);
      float x = map(i, 0, OpusN.size(), 210, 340);
      vertex(x, y);
    }
    endShape();
    beginShape();
    for (int i = 0; i < HachiN.size(); i++) {
      float y = map(HachiN.get(i), 0, 100, height-10, height-110);
      float x = map(i, 0, HachiN.size(), 560, 690);
      vertex(x, y);
    }
    endShape();
    beginShape();
    for (int i = 0; i < PlantN.size(); i++) {
      float y = map(PlantN.get(i), 0, 100, height-10, height-110);
      float x = map(i, 0, PlantN.size(), 780, 930);
      vertex(x, y);
    }
    endShape();
  }
}
