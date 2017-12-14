class Particle{
  PVector pos = new PVector();
  PVector opos = new PVector();
  PVector vel = new PVector();
  boolean dead = false;
  int c = color(255, 0, 0);
  int age = 0;
  int maxAge = 200;
  float alpha = 255;
  float alphaAmt = 255 / (maxAge >> 1);
  
  Particle(float x, float y){
    setPos(x, y);
  }
  Particle(PVector position){
    setPos(position);
  }
  
  void setColor(int col){
    c = col;
  }
  
  void respawn(float x, float y){
    setPos(x, y);
    age = 0;
    alpha = 255;
    dead = false;
  }
  void respawn(PVector p){
    respawn(p.x, p.y);
  }
  
  void update(){
    vel = PVector.sub(pos, opos);
    opos = pos.copy();
    pos = PVector.add(pos, vel);
    pos.add(grav);
    
    age++;
    if(age > (maxAge >> 1)){
      alpha -= alphaAmt;
      if(age > maxAge){
        dead = true;
      }  
    }
    
    if(useBounds){
      if(pos.x > width || pos.x < 0){
        pos.x = (pos.x < 0) ? 0 : width;
        vel.x *= -.8f;
        setVel(vel);
      }
      if(pos.y > height || pos.y < 0){
        pos.y = (pos.y < 0) ? 0 : height;
        vel.y *= -.8f;
        setVel(vel);
      }
    }
  }
  
  void show(){
    fill(c, alpha);
    if(drawTrail){
      stroke(c, alpha);
      strokeWeight(2);
      line(pos.x, pos.y, opos.x, opos.y);
    }else{
      noStroke();
    }
    point(pos.x, pos.y);
    //ellipse(pos.x, pos.y, 3, 3);
  }
  
  void setVel(PVector v){
    v.rotate(PI);
    opos = PVector.add(pos, v);
  }
  void setVel(float vx, float vy){
    setVel(new PVector(vx, vy));
  }
  
  void setPos(PVector p){
    setPos(p.x, p.y);
  }
  void setPos(float x, float y){
    pos.x = opos.x = x;
    pos.y = opos.y = y;
  }
}