class Branch{
  
  Branch parent;
  PVector pos;
  PVector dir;
  PVector origDir;
  int count = 0;
  color brown = color(0, 59, 101);
  float len = 5;
  
  Branch(PVector p, PVector d){
    parent = null;
    pos = p;
    dir = d;
    origDir = d.copy();
  }
  
  Branch(Branch p){
    parent = p;
    pos = parent.next();
    dir = parent.dir.copy();
    origDir = dir.copy();
  }
  
  void reset(){
    dir = origDir.copy();
    count = 0;
  }
  
  void show(float sWeight){
    if(parent == null) return;
    stroke(brown);
    strokeWeight(sWeight);
    noFill();
    line(parent.pos.x, parent.pos.y, parent.pos.z, pos.x, pos.y, pos.z);
  }
  
  PVector next(){
    PVector nextDir = PVector.mult(dir, len);
    return PVector.add(pos, nextDir);
  }
}