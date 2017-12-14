class VConst extends VObj{
  //Flag to render constraints
  boolean render = false;
  
  VPoint pA;
  VPoint pB;
  float len;
  float springFactor = 0.5f;
  
  VConst(VPoint pointA, VPoint pointB){
    pA = pointA;
    pB = pointB;
    len = PVector.dist(pA.pos, pB.pos);
  }
  
  void update(){
    PVector dir = PVector.sub(pA.pos, pB.pos);
    float diff = (len - dir.mag()) * springFactor * 0.5f;
    dir.normalize().mult(diff);
    pA.pos.add(dir);
    pB.pos.sub(dir);
  }
  
  void show(){
    if(! render) return;
    stroke(255);
    line(pA.pos.x, pA.pos.y, pB.pos.x, pB.pos.y);
  }
}