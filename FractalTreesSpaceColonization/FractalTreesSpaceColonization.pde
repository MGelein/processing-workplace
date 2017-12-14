Tree tree;
int min_dist = 10;
int max_dist = 50;
float len = 5.0f;

void setup(){
  size(640, 480);
  
  tree = new Tree();
}

void draw(){
  background(51);
  
  tree.show();
  tree.grow();
}