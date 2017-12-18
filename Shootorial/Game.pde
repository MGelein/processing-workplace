class Game{
  
  Ship ship;
  Background bg;
  BulletManager bullets;
  EnemyManager enemies;
  Explosion explosion;
  
  Game(){
    ship = new Ship();
    bg = new Background();
    bullets = new BulletManager();
    enemies = new EnemyManager();
    explosion = new Explosion();
  }
  
  void update(){
    ship.update();
    bg.update();
    bullets.update();
    enemies.update();
    explosion.update();
  }
  
  void show(){
    bg.show();
    ship.show();
    bullets.show();
    enemies.show();
    explosion.show();
    tint(255);
  }
  
  boolean hit(PVector pos1, float w1, float h1, PVector pos2, float w2, float h2){
    if(pos1.x > pos2.x + w2) return false; //left side of ship to the right of right side of enemy
    if(pos1.x + w1 < pos2.x) return false; //right side of ship to the left of left side of enemy
    if(pos1.y > pos2.y + h2) return false; //top side of ship below bottom of enemy
    if(pos1.y + h1 < pos2.y) return false; //bottom of ship above the enemy
    return true;//All of the conditions are met, we have collision
  }
}