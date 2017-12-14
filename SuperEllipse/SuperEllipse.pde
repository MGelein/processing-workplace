void setup(){
  size(400, 400);
}

void draw(){
  background(51);
  translate(width / 2, height / 2);
  
  float r = 100;
  stroke(255);
  noFill();
  
  float a = 100;
  float b = 100;
  float n = 2;
  
  beginShape();
  for(float angle = 0; angle < TWO_PI; angle += 0.1f){
    //float x = r * cos(a);
    //float y = r * sin(a);
    float na = 2/ n;
    float x = pow(abs(cos(angle)), na) * a * sgn(cos(angle));
    float y = pow(abs(sin(angle)), na) * b * sgn(sin(angle));
    vertex(x, y);
  }
  endShape(CLOSE);
}

float sgn(float num){
  //-1 for negative, +1 for positive, 0 for num
  return ((num < 0) ? -1 : (num == 0) ? 0 : 1);
}