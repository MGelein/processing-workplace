class Particle{
  
  PVector pos = new PVector();
  PVector vel;
  PVector acc = new PVector();
  float friction = 1.0f;
  float age = 9001;
  boolean dead = false;
  int c;
  
  Particle(float x, float y, boolean isRoot){
    //Set velocity based on the fact if this is a root of firework
    if(isRoot) {
      vel = new PVector(0, random(-12, -9));
    }else{
      vel = PVector.random2D().mult(random(1, 6));
      friction = 0.85f;
      age = 255;
    }
    
    setPos(x, y);
  }
  
  boolean update(){
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    
    //apply gravity
    applyForce(
      PVector.mult(gravity, (friction == 1.0f) ? 1.0f : random(0.3f, 0.4f)) 
    );
    //Apply tiny bit of wind
    applyForce(PVector.random2D().mult(0.1f));
    
    //apply friction
    vel.mult(friction);
    
    age -= 4;
    if(age < 0 || pos.y > height || pos.x < 0 || pos.x > width){
      dead = true;
    }
    //Return if we want to live
    return !dead;
  }
  
  void show(){
    stroke(c, age);
    line(pos.x, pos.y, pos.x - vel.x, pos.y - vel.y);
  }
  
  void applyForce(PVector f){
    acc.add(f);
  }
  
  void setPos(float x, float y){
    pos.x = x;
    pos.y = y;
  }
  void setPos(PVector p){
    setPos(p.x, p.y);
  }
}