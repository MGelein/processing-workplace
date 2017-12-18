class BulletManager{
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  void update(){
    for(int i = bullets.size() - 1; i >= 0; i--){
      if(!bullets.get(i).update()){
        bullets.remove(i);
      }
    }
  }
  
  void addBullet(Bullet b){
    bullets.add(b);
  }
  
  ArrayList<Bullet> getList(){
    return bullets;
  }
  
  void show(){
    //First draw black outline
    strokeWeight(7);
    stroke(0);
    for(Bullet b : bullets) b.show();
    //Then draw white inner surface
    strokeWeight(3);
    stroke(255);
    for(Bullet b : bullets) b.show();
  }
}