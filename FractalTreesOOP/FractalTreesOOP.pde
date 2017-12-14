int hue = 0;

ArrayList<Branch> tree = new ArrayList<Branch>();

void setup(){
  size(800, 600);
  colorMode(HSB);
}

//On mouse press add a new tree
void mousePressed(){
  float x = random(-20, 20) + mouseX;
  float h = random(50, 220);
  float a = random(PI / 8, PI / 2.5);
  PVector start = new PVector(x, height);
  PVector end = new PVector(x, height - h);
  Branch root = new Branch(start, end, a, color(hue, 255, 100));
  
  tree.add(root);
  
  hue+=25;
  if(hue > 255) hue = 0;
}

void draw(){
  background(51);
  stroke(255);
  
  for(Branch b : tree){
    b.show();
  }
}