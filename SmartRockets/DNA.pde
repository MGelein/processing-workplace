class  DNA{
  PVector[] genes = new PVector[lifespan];
  
  DNA(){
    for(int i = 0; i < genes.length; i++){
      genes[i] = PVector.random2D();
      genes[i].setMag(maxForce);
    }
  }
  
  DNA crossover(DNA parent){
    DNA newDNA = new DNA();
    for(int i = 0; i < newDNA.genes.length; i++){
      float chance = random(1);
      if(chance < 0.01){
        //SKIP, keep random VECTOR
      }else if(chance < 0.505){
        newDNA.genes[i] = parent.genes[i];
      }else{
        newDNA.genes[i] = genes[i];
      }
    }
    return newDNA;
  }
}