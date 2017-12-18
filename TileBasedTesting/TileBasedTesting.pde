Grid g;

void setup(){
  size(640, 360);
  
  g = new Grid();
}

void draw(){
  background(0);
  
  g.show();
}