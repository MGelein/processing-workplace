class Bullet{
 
  PVector pos;
  PVector vel;
  boolean hit;
  
  Bullet(float x, float y){
    pos = new PVector(x, y);
    vel = new PVector(10, 0);
  }
  
  boolean update(){
    pos.add(vel);
    if(pos.x > width + 10){
      return false;
    }
    
    doHittest();
    
    return !hit;
  }
  
  void doHittest(){
    //First test hit on Ship, only if you are opposing bullet
    if(game.hit(game.ship.pos, game.ship.w, game.ship.h, pos, 0, 0)){
      hit = true;
    }
    
    //Then on all enemies
    for(Enemy e : game.enemies.getList()){
      if(game.hit(e.pos, e.w, e.h, pos, 0, 0)){
        hit = true;
        e.hit = true;
        game.explosion.spawn(e.pos, 10);
      }
    }
    
    //Then on all bullets
    for(Bullet b : game.bullets.getList()){
      if(b == this) continue;
      if(game.hit(b.pos, 0, 0, pos, 0, 0)){
        hit = true;
        b.hit = true;
      }
    }
  }

  
  void show(){
    line(pos.x - 2, pos.y, pos.x + 2, pos.y);
  }
}