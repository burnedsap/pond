class ChildApplet extends PApplet {
  //JFrame frame;
  CheckBox checkbox;
  Knob myKnobP;
  public ChildApplet() {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(440, 850);
  }
  public void setup() {
    surface.setTitle("Controllers");
    cp5 = new ControlP5(this);

    cp5.addTextlabel("label1")
      .setText("Plants")
      .setPosition(10, 30)
      .setColorValue(0xffffff00)
      ;

    cp5.addSlider("MinPlant")
      .setBroadcast(false)
      .setSize(300, 20)
      .setPosition(10, 50)
      .setRange(1, 30)
      .setValue(10)
      .setNumberOfTickMarks(30)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;
    cp5.addSlider("PlantRegen")
      .setBroadcast(false)
      .setSize(300, 20)
      .setPosition(10, 80)
      .setRange(0.001, 0.5)
      .setValue(0.1)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;
    cp5.addSlider("MaxPlant")
      .setBroadcast(false)
      .setSize(300, 20)
      .setPosition(10, 110)
      .setRange(20, 200)
      .setValue(100)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;

    cp5.addTextlabel("label2")
      .setText("Opus")
      .setPosition(10, 140)
      .setColorValue(0xffffff00)
      ;

    cp5.addRange("Opus Vision")
      .setBroadcast(false)
      .setPosition(10, 160)
      .setSize(300, 20)
      .setHandleSize(20)
      .setRange(5, 150)
      .setRangeValues(20, 90)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;
    cp5.addRange("Opus Max Speed")
      .setBroadcast(false)
      .setPosition(10, 190)
      .setSize(300, 20)
      .setHandleSize(20)
      .setRange(0.5, 15)
      .setRangeValues(2, 5)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;
    cp5.addRange("Opus Age")
      .setBroadcast(false)
      .setPosition(10, 220)
      .setSize(300, 20)
      .setHandleSize(20)
      .setRange(2000, 8000)
      .setRangeValues(5000, 6000)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;
    cp5.addRange("Opus Htr")
      .setBroadcast(false)
      .setPosition(10, 250)
      .setSize(300, 20)
      .setHandleSize(20)
      .setRange(2, 12)
      .setRangeValues(5, 9)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;
    cp5.addRange("Opus Initial Hunger")
      .setBroadcast(false)
      .setPosition(10, 280)
      .setSize(300, 20)
      .setHandleSize(20)
      .setRange(1, 10)
      .setRangeValues(2, 5)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;

    cp5.addTextlabel("label3")
      .setText("Hachi")
      .setPosition(10, 310)
      .setColorValue(0xffffff00)
      ;

    cp5.addRange("Hachi Age")
      .setBroadcast(false)
      .setPosition(10, 330)
      .setSize(300, 20)
      .setHandleSize(20)
      .setRange(2000, 8000)
      .setRangeValues(5000, 6000)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;
    cp5.addRange("Hachi Htr")
      .setBroadcast(false)
      .setPosition(10, 360)
      .setSize(300, 20)
      .setHandleSize(20)
      .setRange(2, 12)
      .setRangeValues(5, 9)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;
    cp5.addRange("Hachi Initial Hunger")
      .setBroadcast(false)
      .setPosition(10, 390)
      .setSize(300, 20)
      .setHandleSize(20)
      .setRange(1, 10)
      .setRangeValues(2, 5)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;
    cp5.addRange("Hachi Vision")
      .setBroadcast(false)
      .setPosition(10, 420)
      .setSize(300, 20)
      .setHandleSize(20)
      .setRange(5, 150)
      .setRangeValues(20, 90)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;
    cp5.addRange("Hachi Max Speed")
      .setBroadcast(false)
      .setPosition(10, 450)
      .setSize(300, 20)
      .setHandleSize(20)
      .setRange(0.5, 15)
      .setRangeValues(2, 5)
      .setColorActive(color(255, 255, 0))
      .setBroadcast(true)
      ;

    cp5.addToggle("ShareFood")
      .setPosition(10, 500)
      .setSize(50, 20)
      .setColorActive(color(255, 255, 0))
      ;

    cp5.addToggle("EnvironmentFriendly")
      .setPosition(100, 500)
      .setSize(50, 20)
      .setColorActive(color(255, 255, 0))
      ;


    cp5.addKnob("Plants")
      .setRange(0, 150)
      .setValue(70)
      .setPosition(40, 600)
      .setRadius(50)
      .setColorForeground(color(255))
      .setColorActive(color(255, 255, 0))
      .setDragDirection(Knob.HORIZONTAL)
      ;
    cp5.addKnob("Opus")
      .setRange(0, 100)
      .setValue(50)
      .setPosition(170, 600)
      .setRadius(50)
      .setColorForeground(color(255))
      .setColorActive(color(255, 255, 0))
      .setDragDirection(Knob.HORIZONTAL)
      ;
    cp5.addKnob("Hachi")
      .setRange(0, 70)
      .setValue(20)
      .setPosition(300, 600)
      .setRadius(50)
      .setColorForeground(color(255))
      .setColorActive(color(255, 255, 0))
      .setDragDirection(Knob.HORIZONTAL)
      ;

    cp5.addButton("Reset")
      .setValue(0)
      .setPosition(120, 780)
      .setSize(200, 20)
      .setColorActive(color(255, 255, 0))
      ;

    noStroke();
  }

  public void draw() {
    background(150);
  }

  public void ShareFood(boolean theFlag) {
    if (theFlag==true) {
      OpusShare = 0.5;
    } else {
      OpusShare = 1;
    }
  }
  public void EnvironmentFriendly(boolean theFlag) {
    if (theFlag==true) {
      OpusCare = 0.1;
    } else {
      OpusCare = 1;
    }
  }

  public void Plants(int theValue) {
    numberPlant = theValue;
  }
  public void Opus(int theValue) {
    numberOpus = theValue;
  }
  public void Hachi(int theValue) {
    numberHachi = theValue;
  }

  public void controlEvent(ControlEvent theControlEvent) {

    if (theControlEvent.isFrom("Opus Age")) {
      OpusAgeMin = int(theControlEvent.getController().getArrayValue(0));
      OpusAgeMax = int(theControlEvent.getController().getArrayValue(1));
    }
    if (theControlEvent.isFrom("Opus Htr")) {
      OpusHtrMin = int(theControlEvent.getController().getArrayValue(0));
      OpusHtrMax = int(theControlEvent.getController().getArrayValue(1));
    }
    if (theControlEvent.isFrom("Opus Initial Hunger")) {
      OpusHungerMin = int(theControlEvent.getController().getArrayValue(0));
      OpusHungerMax = int(theControlEvent.getController().getArrayValue(1));
    }
    if (theControlEvent.isFrom("Opus Vision")) {
      OpusVisionMin = int(theControlEvent.getController().getArrayValue(0));
      OpusVisionMax = int(theControlEvent.getController().getArrayValue(1));
    }
    if (theControlEvent.isFrom("Opus Max Speed")) {
      OpusSpeedMin = int(theControlEvent.getController().getArrayValue(0));
      OpusSpeedMax = int(theControlEvent.getController().getArrayValue(1));
    }
    if (theControlEvent.isFrom("Hachi Age")) {
      HachiAgeMin = int(theControlEvent.getController().getArrayValue(0));
      HachiAgeMax = int(theControlEvent.getController().getArrayValue(1));
    }
    if (theControlEvent.isFrom("Hachi Htr")) {
      HachiHtrMin = int(theControlEvent.getController().getArrayValue(0));
      HachiHtrMax = int(theControlEvent.getController().getArrayValue(1));
    }
    if (theControlEvent.isFrom("Hachi Initial Hunger")) {
      HachiHungerMin = int(theControlEvent.getController().getArrayValue(0));
      HachiHungerMax = int(theControlEvent.getController().getArrayValue(1));
    }
    if (theControlEvent.isFrom("Hachi Vision")) {
      HachiVisionMin = int(theControlEvent.getController().getArrayValue(0));
      HachiVisionMax = int(theControlEvent.getController().getArrayValue(1));
    }
    if (theControlEvent.isFrom("Hachi Max Speed")) {
      HachiSpeedMin = int(theControlEvent.getController().getArrayValue(0));
      HachiSpeedMax = int(theControlEvent.getController().getArrayValue(1));
    }
  }

  public void MinPlant(float theColor) {
    minPlantVal = theColor;
  }

  public void PlantRegen(float theColor) {
    PlantRegenVal = theColor;
  }

  public void MaxPlant(float theColor) {
    maxPlantVal = theColor;
  }

  public void Reset() {
    println("Reset");
    world = null;
    totalTime = 0;
    timer = 0;
    OpusN.clear();
    HachiN.clear();
    PlantN.clear();
    clear();
    world = new World(numberHachi, numberOpus, numberPlant);
  }
}
