class Laser{
  PVector pos = new PVector();
  PVector vel = new PVector();
  boolean dead = false;
  
  public Laser(PVector shipPos, float angle){
    pos = shipPos.copy();
    vel = PVector.fromAngle(angle - PI / 2);
    vel.mult(10).add(ship.velocity);
  }
  
  void update(){
    pos.add(vel);
  }
  
  void edges(){
    if(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height){
      dead = true;
    }
  }
  
  boolean hits(Asteroid a){
    if(dead) return false;
    float d = dist(pos.x, pos.y, a.pos.x, a.pos.y);
    return d < a.r;
  }
  
  void render(){
    stroke(255);
    strokeWeight(5);
    point(pos.x, pos.y);
    strokeWeight(1);
    edges();
  }
}
