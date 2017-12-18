int n = 0; //Dot counter
float c = 8.0f; //Dot scaling factor;
float r = 0.0f; //Dot radius
float a = 0.0f; //Dot angle

float x = 0.0f;
float y = 0.0f;

float w2;
float h2;



void setup(){
  size(400, 400);
  background(0);
  w2 = width / 2;
  h2 = height / 2;
  colorMode(HSB);
}

void draw(){
  
  a = radians(n * 137.5);
  r = c * sqrt(n);
  
  x = r * cos(a) + w2;
  y = r * sin(a) + h2;
  
  
  noStroke();
  fill(color(n % 255, 255, 255));
  ellipse(x, y, c + 2, c + 2);
  
  //In next cycle draw the next ellipse
  n++;
  
  if(r > width && r > height){
    println("Stop looping");
    noLoop();
  }
}