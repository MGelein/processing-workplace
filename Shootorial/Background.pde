class Background extends Sprite{
  
  PVector pos;
  PVector vel;
  
  Background(){
    super(imageLoader.bg);
    pos = new PVector(0, height - h);
    vel = new PVector(-1f, 0);
    
  }
  
  void update(){
    pos.add(vel);
    
    if(pos.x < -w){
      pos.x = 0;
    }
  }
  
  void show(){
    image(imageLoader.bg, pos.x, pos.y);
    image(imageLoader.bg, pos.x + w, pos.y);
  }
}