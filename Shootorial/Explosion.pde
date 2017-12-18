class Explosion{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  ArrayList<Particle> pool = new ArrayList<Particle>();
  
  void update(){
    for(int i = particles.size() - 1; i >= 0; i--){
      if(! particles.get(i).update()){
        pool.add(particles.remove(i));
      }
    }
  }
  
  void spawn(PVector pos, int size){
    Particle p;
    for(int i = 0; i < size; i++){
      if(pool.size() > 0){
        p = pool.remove(0);
        p.spawn(pos);
      }else{
        p = new Particle(pos);
      }
      particles.add(p);
    }
  }
  
  void show(){
    for(Particle p : particles) p.show();
  }
}