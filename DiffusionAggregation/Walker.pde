class Walker{
  PVector pos;
  boolean stuck = false;
 
  Walker(){
    pos = new PVector(random(width), random(height));
  }
  
  Walker(float x, float y){
    pos = new PVector(x, y);
  }
  
  void walk(){
    PVector vel = PVector.random2D();
    pos.add(vel);
    pos.x = constrain(pos.x, 0, width);
    pos.y = constrain(pos.y, 0, height);
  }
  
  boolean checkStuck(ArrayList<PVector> tree){
    for(PVector v : tree){
      if(PVector.dist(v, pos) < r * 2){
        return true;
      }
    }
    return false;
  }
  
  void show(){
    strokeWeight(r * 2);
    stroke(255);
    point(pos.x, pos.y);
  }
}