Ship ship;
boolean leftDown = false;
boolean rightDown = false;
boolean upDown = false;
boolean spaceDown = false;

ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Laser> lasers = new ArrayList<Laser>();

void setup(){
  size(1280, 720);
  
  ship = new Ship();
  for(int i = 0; i < 10; i++){
    asteroids.add(new Asteroid());  
  }  
}

void draw(){
  background(0);
  if(leftDown) ship.turn(-ship.turnForce);
  if(rightDown) ship.turn(ship.turnForce);
  if(upDown) ship.boost();
  if(spaceDown && ship.rate < 0){
    ship.rate = ship.cooldown;
    lasers.add(new Laser(ship.pos, ship.heading));
  }
  
  for(Asteroid a : asteroids){
    a.render();
  }
  
  ArrayList<Asteroid> toAdd = new ArrayList<Asteroid>();
  for(Laser l : lasers){
    l.update();
    l.render();
    for(Asteroid a : asteroids){
      if(l.hits(a)){
        l.dead = true;
        toAdd.addAll(a.breakUp());
      }
    }
  }
  asteroids.addAll(toAdd);
  
  ship.render();
  
  for(int i = lasers.size() - 1; i >= 0; i--){
    if(lasers.get(i).dead){
      lasers.remove(i);
    }
  }
  
  for(int i = asteroids.size() - 1; i >= 0; i--){
    if(asteroids.get(i).dead){
      asteroids.remove(i);
    }
  }
}

void keyPressed(){
  if(keyCode == LEFT) leftDown = true;
  if(keyCode == RIGHT) rightDown = true;
  if(keyCode == UP) upDown = true;
  if(keyCode == 32) spaceDown = true;
}

void keyReleased(){
  if(keyCode == LEFT) leftDown = false;
  if(keyCode == RIGHT) rightDown = false;
  if(keyCode == UP) upDown = false;
  if(keyCode == 32) spaceDown = false;
}
