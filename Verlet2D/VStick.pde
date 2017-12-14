class VStick extends VObj{
  VPoint p1;
  VPoint p2;
  VConst c;
  
  VStick(float x1, float y1, float x2, float y2){
    init(x1, y1, x2, y2);
  }
  VStick(PVector v1, PVector v2){
    init(v1.x, v1.y, v2.x, v2.y);
  }
  VStick(VPoint pointA, VPoint pointB){
    p1 = pointA;
    p2 = pointB;
    c = new VConst(p1, p2);
  }
  
  PVector midPoint(){
    return PVector.sub(p1.pos, PVector.sub(p1.pos, p2.pos).mult(0.5f));
  }
  
  void init(float x1, float y1, float x2, float y2){
    p1 = new VPoint(x1, y1);
    p2 = new VPoint(x2, y2);
    c = new VConst(p1, p2);
  }
  
  void update(){
    p1.update();
    p2.update();
    c.update();
  }
  
  void show(){
    p1.show();
    p2.show();
    c.show();
    //draw line for self
    noFill();
    stroke(255);
    line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);
  }
  
  void setRigidity(float f){
    f = constrain(f, 0.0f, 1.0f);
    c.springFactor = f;
  }
}