class Ship{
  PVector pos = new PVector(width / 2, height /2);
  float r = 20;
  float heading = 0;
  float rotation = 0;
  float turnForce = 0.02;
  float cooldown = 5;
  float rate = cooldown;
  PVector velocity = new PVector();
  
  void render(){
    pushMatrix();
    translate(pos.x, pos.y);
    pos.add(velocity);
    velocity.mult(0.96);
    rotate(heading);
    heading += rotation;
    rotation *= 0.7f;
    fill(0);
    stroke(255);
    triangle(-r, r, r, r, 0, -r);
    edges();
    popMatrix();
    rate --;
  }
  
  void edges(){
    if(pos.x > width + r){
      pos.x = -r;
    }else if(pos.x < -r){
      pos.x = width + r;
    }
    if(pos.y > height + r){
      pos.y = -r;
    }else if(pos.y < -r){
      pos.y = height + r;
    }
  }
  
  void boost(){
    PVector vec = PVector.fromAngle(heading - PI / 2);
    vec.mult(0.5);
    velocity.add(vec);
  }
  
  void turn(float a){
    rotation += a;
  }
}
