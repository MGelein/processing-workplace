import peasy.*;

Tree tree;
int min_dist = 5;
int max_dist = 200;

PeasyCam cam;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 900);
  cam.setYawRotationMode();
  tree = new Tree();
  colorMode(HSB);
}

void draw() {
  background(51);
  tree.show();
  tree.grow();
}