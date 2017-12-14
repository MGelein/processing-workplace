class VPoint extends VObj{
  //Flag to render points
  boolean render = false;
  
  PVector pos = new PVector();// position
  PVector opos; // old position
  PVector temp;
  float r = 4;
  
  VPoint(float x, float y){
    setPos(x, y, false);
  }
  VPoint(PVector nPos){
    setPos(nPos, false);
  }
  
  void update(){
    //Basic verlet integration
    temp = PVector.sub(pos, opos);
    //Apply friciton
    temp.mult(world.friction);
    
    opos = pos.copy();
    pos.add(temp);
    
    //add gravity
    pos.add(world.gravity);
    
    
    //stay in bounding box (screen)
    if(pos.x > width - r || pos.x < 0 + r){
      pos.x = (pos.x < 0) ? r : width - r;
      temp.x *= -.8f;
      opos = PVector.sub(pos, temp);
    }
    if(pos.y > height - r || pos.y < 0 + r){
      pos.y = (pos.y < 0) ? r : height - r;
      temp.y *= -.8f;
      opos = PVector.sub(pos, temp);
    }
  }
  
  void show(){
    if(! render) return;
    noFill();
    stroke(255);
    ellipse(pos.x, pos.y, r, r);
  }
  
  void setPos(float x, float y, boolean keepMomentum){
    pos.x = x;
    pos.y = y;
    if(!keepMomentum) opos = pos.copy();
  } 
  void setPos(PVector nPos, boolean keepMomentum){
    setPos(nPos.x, nPos.y, keepMomentum);
  }
}