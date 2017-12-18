class Particle extends Sprite{
  PVector pos;
  PVector vel;
  int age = 0;
  
  Particle(PVector p){
    super(imageLoader.smoke);
    spawn(p);
  }
  
  void spawn(PVector p){
    age = 0;
    pos = p.copy();
    vel = new PVector();
  }
  
  boolean update(){
    age ++;
    pos.add(vel);
    vel.mult(0.9f);
    if(pos.x > width || pos.x < 0) return false;
    if(pos.y < 0) return false;
    
    vel.y -= 0.2f;
    vel.x += random(-.1f, .1f);
    
    if(age > w) return false;
    
    return true;
  }
  
  void show(){
    tint(255, (1 - (age / w)) * 255);
    image(imageLoader.smoke, pos.x - age / 2, pos.y - age / 2, age, age);
  }
}