/** Surround settings */
PVector grav = new PVector(0, .3f);
boolean useBounds = true;
boolean drawTrail = true;
int RAINBOW = -1;

Source s;
Source s2;

void setup(){
  size(800, 600);
  colorMode(HSB);
  
  s = new Source(500, 300);
  s.setSpawnRate(60, 200);
  s.setColor(color(230, 255, 255));
  
  s2 = new Source(300, 300);
  s2.setSpawnRate(59, 200);
  s2.setColor(color(200, 255, 255));
}

void draw(){
  background(51);
  s.update();
  s2.update();
  s.show();
  s2.show();
}
  