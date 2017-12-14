class Leaf{
  PVector pos;
  boolean reached = false;
  
  Leaf(PVector pos){
    this.pos = pos;
  }
  
  void show(){
    fill(255);
    noStroke();
    ellipse(pos.x, pos.y, 4, 4);
  }
}