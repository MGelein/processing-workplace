class VRect extends VObj{
  ArrayList<VStick> sticks = new ArrayList<VStick>();
  VStick diagonal;//Keep track of this for center 
  
  VRect(float left, float top, float w, float h){
    init(left, top, w, h);
  }
  VRect(PVector topLeft, PVector dimensions){
    init(topLeft.x, topLeft.y, dimensions.x, dimensions.y);
  }  
  void init(float left, float top, float w, float h){
     VPoint tl = new VPoint(left, top);
     VPoint tr = new VPoint(left + w, top);
     VPoint br = new VPoint(left + w, top + h);
     VPoint bl = new VPoint(left, top + h);
     
     sticks.add(new VStick(tl, tr));
     sticks.add(new VStick(tr, br));
     sticks.add(new VStick(br, bl));
     sticks.add(new VStick(bl, tl));
     sticks.add(new VStick(tl, br));
     diagonal = new VStick(tr, bl);
     sticks.add(diagonal);
  }
  
  void rotate(float angle, boolean keepMomentum){
    PVector center = diagonal.midPoint();
    //Set the position of the first point in every stick
    int i, max = 4; VPoint p; PVector diff;
    for(i = 0; i < max; i++){
      p = sticks.get(i).p1;
      diff = PVector.sub(center, p.pos);
      diff.rotate(angle);
      p.setPos(PVector.add(center, diff), keepMomentum);
    }
  }
  void rotate(float angle){
    rotate(angle, false);
  }
  
  void update(){
    for(VStick s : sticks){ s.update();}
  }
  
  void show(){
    for(VStick s : sticks){ s.show();}
  }
}