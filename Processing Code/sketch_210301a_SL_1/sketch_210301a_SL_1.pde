ArrayList<Being> bg = new ArrayList<Being>(); //<>//
ArrayList<Food> fd = new ArrayList<Food>();

void setup() {
  size(400, 400);
  rectMode(CENTER);
  for (int i=0; i<4; i++) {
    bg.add(new Being(random(width), random(height)));
  }
  for (int i=0; i<40; i++) {
    fd.add(new Food(random(width), random(height)));
  }
}

void draw() {
  background(240); 

  for (int i=0; i<fd.size(); i++) {
    Food part = fd.get(i);
    part.display();
  }

  for (int i=0; i<bg.size(); i++) {
    Being part = bg.get(i);
    part.move();
    part.wall();
    part.display();
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
    //println(inventory);
    //for(int x=0; x<inventory.size(); x++) {
    //  println(fd.get(inventory.get(x)).loc);
    //}
    for(int x=0; x<distance.size(); x++) {
      //println(fd.get(distance.index(distance.min())).loc);
      bpart.arrive(fd.get(distance.index(distance.min())).loc);
    }
  }
  
}
