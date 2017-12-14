class Source{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  ArrayList<Particle> pool = new ArrayList<Particle>();
  PVector pos = new PVector();
  int spawnDelay = 0;
  int delay = 0;
  int spawnAmt = 1;
  int amt = 0;
  float spawnVel = 10.0f;
  PVector spawnDir = PVector.random2D();
  float spawnAngle = 800;
  float angle = 0.0f;
  float hue = 0f;
  float sat = 255f;
  float brg = 180f;
  int c = color(hue, sat, brg);
  
  Source(float x, float y){
    setPos(x, y);
  }
  Source(PVector position){
    setPos(position);
  }
  
  void update(){
    delay ++;
    if(delay >= spawnDelay){
      spawn();
      delay = 0;
    }
    
    if(spawnAngle < 500){
      spawnAngle += angle;
      if(spawnAngle > TWO_PI){
        spawnAngle = 0;
      }
    }
    
    
    for(Particle p : particles){p.update();}
    for(int i = particles.size() - 1; i >= 0; i--){
      if(particles.get(i).dead){
        pool.add(particles.remove(i));
      }
    }
  }
  
  void setRotating(float dAngle){
    if(dAngle > 500){
      spawnAngle = 800;
    }else{
      angle = dAngle;
    }
  }
  
  void setDirection(PVector dir, float vel){
    if(vel >= 0){
      spawnDir = dir;
      spawnVel = vel;
    }    
  }
  
  void setColor(int col){
    if(col == RAINBOW){
      hue = 0.5f;
    }else{
      hue = 0f;
      c = col;
    }
  }
  
  void show(){
    for(Particle p : particles){p.show();}
  }
  
  void spawn(){
    for(amt = 0; amt < spawnAmt; amt ++){
      Particle p;
      //First check if there is anything left in the pool
      if(pool.size() > 0){
        p = pool.remove(0);
        p.respawn(pos);
      }else{
        p = new Particle(pos);
      }
      if(spawnVel > 0){
        p.setVel(PVector.random2D().mult(spawnVel));
      }
      if(hue > 0){
        p.setColor(color(hue, sat, brg));
        hue += 1.0f;
        if(hue > 255){
          hue = 0.5f;
        }
      }else{
        p.setColor(c);
      }
      particles.add(p);
    }
  }
  
  void setSpawnRate(int delay, int amt){
    spawnDelay = delay;
    spawnAmt = amt;
  }
  
  void setPos(PVector p){
    setPos(p.x, p.y);
  }
  void setPos(float x, float y){
    pos.x = x;
    pos.y = y;
  }
}