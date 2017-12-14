class Firework{
  
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int c;
  
  boolean dead = false;
  
  Firework(){
    //random color with full brightness and saturation
    c = color(random(255), 255, 255);
    
    //Create the root particle
    particles.add(new Particle(random(width), height, true));
    particles.get(0).c = c;
  }
  
  boolean update(){
    for(int i = particles.size() - 1; i >= 0; i--){
      if(particles.get(i).update()){
        
      }else{
        particles.remove(i);
      }
    }
    
    //If not exploded, check if we're at the top yet
    if(particles.size() == 1 && particles.get(0).vel.y >= 0){
      explode(particles.get(0).pos.x, particles.get(0).pos.y);
      particles.remove(0);
    }
    
    if(particles.size() == 0) dead = true;
    
    //Return if we want to live
    return !dead;
  }
  
  void show(){
    for(Particle p : particles){ p.show();}
  }
  
  void explode(float x, float y){
    bangs[int(random(bangs.length))].play(random(0.9, 1.1f));
    lightLevel = 0.8f;
    lightColor = c;
    for(int i = 0; i < 100; i++){
      particles.add(new Particle(x, y, false));
      particles.get(particles.size() - 1).c = c;
    }
  }
}