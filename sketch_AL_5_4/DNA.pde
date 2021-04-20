class DNA {
  float[][] genes; 

  DNA() {
    genes = new float[6][1];
    for (int j = 0; j < genes.length; j++) {
      for (int i = 0; i < 1; i++) {
        genes[j][i] = random(0, 1);
      }
    }
  }

  DNA(float[][] newgenes) {
    genes = newgenes;
  }

  DNA copy() {
    float[][] newgenes = new float[genes.length][1]; 
    for (int j = 0; j < genes.length; j++) {
      for (int i = 0; i < genes.length; i++) {
        newgenes[j][i] = genes[j][i];
      }
    }

    return new DNA(newgenes);
  }

  void mutate(float m) {//edit
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < m) {
        genes[i][1] = random(0, 1);
      }
    }
  }
}
