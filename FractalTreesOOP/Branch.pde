class Branch{
  boolean RANDOMIZE_ANGLE = true;
  
  PVector start;
  PVector end;
  PVector dir;
  PVector tip;
  
  float cLength;//current
  float tLength;//target
  float angle;
  boolean growing = true;
  int c;//color
  
  ArrayList<Branch> branches;
  
  Branch(PVector start, PVector end, float angle, int c){
    this.start = start;
    this.end = end;
    this.c = c;
    this.angle = angle;
    this.dir = PVector.sub(end, start).normalize();
    tLength = abs(start.dist(end));
    branches = new ArrayList<Branch>();
  }
  
  void show(){
    //First it as thick as it is currently long
    strokeWeight(cLength * 0.2);
    stroke(c);
    tip = PVector.add(start, PVector.mult(dir, cLength));
    line(start.x, start.y, tip.x, tip.y);
    //Thne continue growing if we're still growing, or show children
    if(!growing) {
      for(Branch b : branches) b.show();
      return;
    }
    float diff = (tLength - cLength);
    if(diff < tLength * 0.01) {
      cLength = tLength;
      growing = false;
      //Now branch
      branch(angle);
    }else{
      cLength += diff * 0.1;
    }
  }
  
   void branch(float angle){
     if(RANDOMIZE_ANGLE){
      //slightly vary angle
      float variation = angle * random(0.15);
      angle += random(1) > 0.5 ? variation : -variation;
     }
    PVector target = PVector.sub(end, start);
    target.mult(random(0.6, 0.8));
    //Stop branching for too tiny of a branch
    if(target.mag() < 6) return;
    target.rotate(angle);
    Branch right = new Branch(end, PVector.add(end, target), angle, c);
    target.rotate(angle * -2);
    Branch left = new Branch(end, PVector.add(end, target), angle, c);
    
    branches.add(left);
    branches.add(right);
    
  }
}