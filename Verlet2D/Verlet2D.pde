PVector gravity = new PVector(0, 0.1);

VRect r;
VWorld world;

void setup(){
  size(1280, 720);
  world = new VWorld(gravity);
  r = new VRect(200, 200, 100, 100);
  world.addObj(r);
}
void draw(){
  background(51);
  world.update();
  world.show();
}