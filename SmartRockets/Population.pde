class Population{
  ArrayList<Rocket> rockets = new ArrayList<Rocket>();
  ArrayList<Rocket> matingPool = new ArrayList<Rocket>();
  int popSize = 100;
  
  Population(){
    for(int i = 0; i < popSize; i++){
      rockets.add(new Rocket());
    }
  }
  
  void evaluate(){
    float maxFitness = 0.0000000000001f;//to prevent divide by zero ero
    for(Rocket r : rockets){
      r.calcFitness();
      maxFitness = maxFitness < r.fitness ? r.fitness : maxFitness;
    }
    
    //normalize their fitness to the max found
    for(Rocket r : rockets){
      r.fitness /= maxFitness;
    }
    
    matingPool = new ArrayList<Rocket>();
    
    //Now add it to the mating pool, based on fitness
    for(Rocket r : rockets){
      float n = r.fitness * 100;
      for(int i = 0; i < n; i++){
        matingPool.add(r);
      }
    }
    println("Max fitness: " + maxFitness);
    
    //Mating pool is chance based pool of parents which we pick from 
  }
  
  void selection(){
    ArrayList<Rocket> newRockets = new ArrayList<Rocket>();
    for(int i = 0; i < rockets.size(); i++){
      Rocket parentA = matingPool.get(floor(random(matingPool.size())));
      Rocket parentB = matingPool.get(floor(random(matingPool.size())));
      DNA childDNA = parentA.dna.crossover(parentB.dna);
      newRockets.add(new Rocket(childDNA));
    }
    
    rockets = newRockets;
  }
  
  
  void run(){
    noStroke();
    fill(255, 150);
    
    for(Rocket r : rockets) {r.update(); r.show();}
  }
}