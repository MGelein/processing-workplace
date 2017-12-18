class ImageLoader{
  
  PImage ship;
  PImage bg;
  PImage enemy;
  PImage smoke;
  
  void load(){
    ship = loadImage("ship.png");
    bg = loadImage("bg.jpg");
    enemy = loadImage("enemy.png");
    smoke = loadImage("smoke.png");
  }
}