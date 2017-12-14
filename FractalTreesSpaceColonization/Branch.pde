class Branch{
  
  Branch parent;
  PVector pos;
  PVector dir;
  PVector origDir;
  int count = 0;
  
  Branch(Branch parent, PVector pos, PVector dir){
    this.parent = parent;
    this.pos = pos;
    this.dir = dir;
    this.origDir = dir.copy();
  }
  
  void reset(){
    dir = origDir.copy();
    count = 0;
  }
  
  void show(){
    if(parent == null) return;
    stroke(255);
    noFill();
    line(parent.pos.x, parent.pos.y, pos.x, pos.y);
  }
  
  Branch next(){
    PVector nextDir = PVector.mult(dir, len);
    PVector nextPos = PVector.add(pos, nextDir);
    Branch b = new Branch(this, nextPos, dir.copy());
    return b;
  }
}