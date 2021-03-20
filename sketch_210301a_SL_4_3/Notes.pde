//ref: https://openprocessing.org/sketch/150361
//boolean intersect(Agent other) {
//    float d=PVector.dist(loc, other.loc);
//    if (d>0 && d<r+other.r){
//      flockingBehaviour(other);
//      return true;
//    } else {
//      return false;
//    }
//  }

//void mutate(float m){
//    for(int i=0; i<genes.length; i++){
//      if(random(1)<m)
//      genes[i]=genes[i]+map(genes[0],0,1,0.001,0.01);
//    }
//  }

//Fish mate(Fish partner, float p) {

//      if (random(1)<=p) {
//      DNA childgenes=dna.crossover(partner.dna);
//        childgenes.mutate(mutationRate);
//        childgenes.setSex();
//        return new Fish(childgenes, loc, 1);
//      } else {
//       return null; 
//      }
    
//  }

//DNA crossover(DNA partner){
  
//    float[] child=new float[genes.length];
//    String theText="";
//    for(int i=0; i<genes.length; i++){
//      int n=floor(random(2));

//      if(n==0){
//        child[i]=genes[i];

//      } else {
//        child[i] = partner.genes[i];

//      }
     
//    }
//    return new DNA(child);
//  }
   
//}

//void eat(Food f) {
//    ArrayList<PVector> food=f.getFood();
//    for (int i=food.size()-1; i>=0; i--) {
//      PVector foodLocation=food.get(i);
//      float d=PVector.dist(loc, foodLocation);
//      if (d<r ) {
//        health+=5;
//        if(bodySize<maxSize){
//          bodySize+=growthRate*2;
//          stage++;
//        }
//        food.remove(i);
//      }
//    }
//  }
