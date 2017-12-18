class EnemyManager{
  
  int spawnCounter = 60;
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  
  
  void update(){
    for(int i = enemies.size() - 1; i >= 0; i --){
      if(!enemies.get(i).update()){
        enemies.remove(i);
      }
    }
    spawnCounter --;
    
    if(spawnCounter < 0) spawn();
  }
  
  void spawn(){
    enemies.add(new Enemy());
    spawnCounter = floor(random(20)) + 80;
  }
  
  ArrayList<Enemy> getList(){
    return enemies;
  }
  
  void show(){
    for(Enemy e : enemies) e.show();
  }
}