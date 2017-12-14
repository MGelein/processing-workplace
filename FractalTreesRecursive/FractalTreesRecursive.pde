float angle = 0;

void setup(){
 size(800, 600);
}

void draw(){
  background(51);
  stroke(255);
  translate(width / 2, height);
   
  branch(150);
}

void branch(float len){
  angle = map(mouseX, 0, width, PI / 16, PI / 3);
  strokeWeight(len * 0.2);
  line(0, 0, 0, -len);
  translate(0, -len);
  if(len > 6){
    pushMatrix();
    rotate(angle);
    branch(len * 0.67);
    popMatrix();
    pushMatrix();
    rotate(-angle);
    branch(len * 0.67);
    popMatrix();
  }
}