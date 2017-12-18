class Enemy extends Sprite{
  
  PVector pos;
  PVector vel;
  boolean hit = false;
  
  Enemy(){
    super(imageLoader.enemy);
    pos = new PVector(width + 100, random(height - 100) + 50);
    vel = new PVector(-3 + random(-2, 0),0);
  }
  
  boolean update(){
    pos.add(vel);
    
    if(pos.x < - w){
      return false;
    }
    
    doHittest();
    
    return !hit;
  }
  
  void doHittest(){
    //First test hit on Ship
    if(game.hit(game.ship.pos, game.ship.w, game.ship.h, pos, 0, 0)){
      hit = true;
      game.explosion.spawn(pos, 10);
    }
    
    //Then on all bullets
    for(Bullet b : game.bullets.getList()){
      if(game.hit(b.pos, 0, 0, pos, 0, 0)){
        hit = true;
        b.hit = true;
      }
    }
  }
  
  void show(){
    image(imageLoader.enemy, pos.x, pos.y);
  }
}