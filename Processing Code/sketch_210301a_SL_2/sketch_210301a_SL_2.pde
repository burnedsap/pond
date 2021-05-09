ArrayList<Being> bg = new ArrayList<Being>(); //<>//
ArrayList<Food> fd = new ArrayList<Food>();

void setup() {
  size(600, 400);
  rectMode(CENTER);
  for (int i=0; i<10; i++) {
    bg.add(new Being(random(width), random(height)));
  }
  for (int i=0; i<100; i++) {
    fd.add(new Food(random(width), random(height)));
  }
}

void draw() {
  background(240); 
  generateFood();
  cullBeings();
  for (int i=0; i<fd.size(); i++) {
    Food part = fd.get(i);
    part.display();
  }

  for (int i=0; i<bg.size(); i++) {
    Being part = bg.get(i);
    part.separate(bg);
    part.neutralState();

    //multiply
    if (part.hunger>4) {
      part.hunger=1;
      bg.add(new Being(part.loc.x, part.loc.y));
    }
  }

  for (int i=0; i<bg.size(); i++) {
    Being bpart = bg.get(i);
    //IntList inventory;
    FloatList distance;
    //inventory = new IntList();
    distance = new FloatList();
    for (int j=0; j<fd.size(); j++) {
      Food fpart = fd.get(j);

      //find closest food
      if (dist(fpart.loc.x, fpart.loc.y, bpart.loc.x, bpart.loc.y) < 50) {
        //inventory.append(j);
        distance.append(dist(fpart.loc.x, fpart.loc.y, bpart.loc.x, bpart.loc.y));
      }

      //remove eaten food and add to hunger
      if (dist(fpart.loc.x, fpart.loc.y, bpart.loc.x, bpart.loc.y) < 10) {
        fd.remove(j);
        bpart.hunger++;
      }
    }
    if (fd.size()>0) {
      for (int x=0; x<distance.size(); x++) {
        bpart.separate(bg);
        bpart.foodState(fd.get(distance.index(distance.min())).loc);
      }
    }
  }
}


void generateFood() {
  if (frameCount%100==1) {
    fd.add(new Food(random(width), random(height))); 
    //println("fud");
  }
}

void cullBeings() {
  for (int i=0; i<bg.size(); i++) {
    Being part = bg.get(i);
    if (part.hunger<=0) {
      bg.remove(i);
      fd.add(new Food(part.loc.x, part.loc.y));
    }
    if (part.timeAlive >= 1500) {
      bg.remove(i);
      fd.add(new Food(part.loc.x, part.loc.y));
    }
  }
}
