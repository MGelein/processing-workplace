Population p;
int lifespan = 300;
int age = 0;
PVector target;
float rx;
float ry;
float rw = 100.0f;
float rh = 10.0f;
float maxForce = 0.2f;

void setup(){
  size(400, 300);
  p = new Population();
  rectMode(CENTER);
  
  rx = width / 2;
  ry = height / 2;
  target = new PVector(width / 2, 20);
}

void draw(){
  background(51);
  
  //Draw obstacle
  rect(rx, ry, rw, rh);
  
  age++;
  if(age == lifespan){
    p.evaluate();
    p.selection();
    age = 0;
  }
  p.run();
  
  ellipse(target.x, target.y, 16, 16);
}