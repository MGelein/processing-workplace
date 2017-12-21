ArrayList<Walker> tree = new ArrayList<PVector>();
ArrayList<Walker> walkers = new ArrayList<Walker>();
float r = 16;

void setup(){
  size(400, 400);
  
  tree.add(new Walker(width /2, height/ 2));
  walkers.add(new Walker());
}

void draw(){
  background(0);
  
  for(Walker w : tree){
    w.show();
  }
  
  for(Walker w : walkers){
    w.show();
  }
}