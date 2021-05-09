/*
  This is the standard version, to be benchmarked against others
 */
World world;
PFont myFontC;
PFont myFontI;
int timer;
float totalTime = 0;
Table table;
FloatList OpusN = new FloatList();
FloatList HachiN = new FloatList();
FloatList PlantN = new FloatList();

//Variable List

//Hachi
float HachiAgeMin = 3000;
float HachiAgeMax = 6000;
float HachiHtrMin = 5;
float HachiHtrMax = 9;
float HachiHungerMin = 2;
float HachiHungerMax = 5;
float HachiVisionMin = 20;
float HachiVisionMax = 90;
float HachiSpeedMin = 1;
float HachiSpeedMax = 4;

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

//Plant

float minPlantVal = 10;
float PlantRegenVal = 0.004;
float maxPlantVal = 100;

void setup() {
  size(900, 600, FX2D);

  //All objects living within a 'World'
  world = new World(10, 40, 70); //refers to number of Hachi(3rd in food chain) Opus(2nd in food chain) Plants on start

  //load in custom fonts
  myFontC = loadFont("CircularStd-Medium-14.vlw");
  myFontI = loadFont("Inter-Regular-12.vlw");
  table = new Table();

  table.addColumn("opus-number");
  table.addColumn("opus-avg-speed");
  table.addColumn("opus-avg-vision");
  table.addColumn("opus-avg-htr");
  table.addColumn("opus-avg-age");
  table.addColumn("hachi-number");
  table.addColumn("hachi-avg-speed");
  table.addColumn("hachi-avg-vision");
  table.addColumn("hachi-avg-htr");
  table.addColumn("hachi-avg-age");
  table.addColumn("plant-number");
}

void draw() {
  background(359, 200);
  totalTime += millis()/1000;
  world.run();
  if (millis() - timer >= 200) {
    TableRow newRow = table.addRow();
    newRow.setInt("opus-number", world.op.size());
    newRow.setFloat("opus-avg-speed", world.OpusAvgSpeed);
    newRow.setFloat("opus-avg-vision", world.OpusAvgVision);
    newRow.setFloat("opus-avg-htr", world.OpusAvgHtr);
    newRow.setFloat("opus-avg-age", world.OpusAvgAge);
    newRow.setInt("hachi-number", world.hc.size());
    newRow.setFloat("hachi-avg-speed", world.HachiAvgSpeed);
    newRow.setFloat("hachi-avg-vision", world.HachiAvgVision);
    newRow.setFloat("hachi-avg-htr", world.HachiAvgHtr);
    newRow.setFloat("hachi-avg-age", world.HachiAvgAge);
    newRow.setInt("plant-number", world.plnt.size());
    OpusN.append(world.op.size());
    HachiN.append(world.hc.size());
    PlantN.append(world.plnt.size());
    totalTime += 1;
    timer = millis();
  }
  noFill();
  stroke(0);
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
    float x = map(i, 0, PlantN.size(), 720, 850);
    vertex(x, y);
  }
  endShape();

  //println(totalTime);

  if (totalTime>5000) {
    saveTable(table, "analytics/data.csv");
    exit();
  }
}
