class Leaf{
  PVector pos;
  PVector dir;
  boolean reached = false;
  color green = color(120, 255, 50);
  
  Leaf(){
    pos = PVector.random3D();
    pos.mult(random(width / 2));
  }
  
  void reached(){
    reached = true;
    dir = new PVector(random(PI), random(PI), random(PI));
  }
  
  void show(){
    if(! reached) return;
    fill(green);
    noStroke();
    pushMatrix();
    rotateX(dir.x);
    rotateY(dir.y);
    rotateZ(dir.z);
    translate(pos.x, pos.y, pos.z);
    ellipse(0, 0, 10, 4);
    popMatrix();
  }
}