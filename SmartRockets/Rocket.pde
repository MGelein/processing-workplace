class Rocket{
  PVector pos = new PVector(width / 2, height);
  PVector vel = new PVector();
  PVector acc = new PVector();
  DNA dna = new DNA();
  float fitness = 0.0f;
  boolean completed = false;
  boolean crashed = false;
  int timeTaken = 0;
  
  Rocket(){}
  Rocket(DNA dna){
    this.dna = dna;
  }
  
  void applyForce(PVector f){
    acc.add(f);
  }
  
  void update(){
    if(completed || crashed) return;
    timeTaken ++;
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
    
    float d = dist(pos.x, pos.y, target.x, target.y);
    if(d < 10.0f){
      completed = true;
    }
    
    if(pos.x < 0 || pos.x > width) crashed = true;
    if(pos.y < 0 || pos.y > height) crashed = true;
    
    //Test if we hit the obstacle
    if(pos.x > rx - (rw / 2) && pos.x < rx + (rw / 2)){
      if(pos.y > ry - (rh / 2) && pos.y < ry + (rh / 2)){
        //Hit obstacle;
        crashed = true;
      }
    }
    
    applyForce(dna.genes[age]);
  }
  
  float calcFitness(){
    float d = dist(pos.x, pos.y, target.x, target.y);
    fitness = 1 / d;
    if(completed){//add a time based boost if we made it
      fitness += (1 / (float(timeTaken) / (float(age))));
    }
    if(crashed) fitness /= 2.0f;
    return fitness;
  }
  
  void show(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading());
    rect(0, 0, 25, 5);
    popMatrix();
  }
}