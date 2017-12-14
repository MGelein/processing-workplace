class Particle{
  PVector pos = new PVector(random(width), random(height));
  PVector vel = new PVector();
  PVector acc = new PVector();
  
  void update(){
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
    vel.mult(0.99);
    
    pos.x = ((pos.x < 0) ? width : (pos.x > width) ? 0: pos.x);
    pos.y = ((pos.y < 0) ? height : (pos.y > height) ? 0: pos.y);
  }
  
  int getFFIndex(){
    return floor(pos.x / scl)  + floor(pos.y / scl) * cols;
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  void show(){
    stroke(0);
    strokeWeight(4);
    point(pos.x, pos.y);
  }
}