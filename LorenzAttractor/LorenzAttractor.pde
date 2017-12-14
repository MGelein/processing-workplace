//Three coordinates of the 'cursor'
float x = 0.01;
float y = 0;
float z = 0;

float a = 10;//sigma
float b = 28;//rho
float c = 8.0f/3.0f;//beta

//List of points of algorithm
ArrayList<PVector> points = new ArrayList<PVector>();

PVector angle = new PVector();

void setup(){
  size(800, 600, P3D);
  colorMode(HSB);
}

void draw(){
  //Draw the background black
  background(0);
  
  //Time step
  float dt = 0.01;
  //Calculate change in coords
  float dx = (a * (y - x)) * dt;
  float dy = (x * (b - z) -y) * dt;
  float dz = (x * y - c * z) * dt;
  //Actually add the coords
  x += dx;
  y += dy;
  z += dz;
  
  //Store this point
  points.add(new PVector(x, y, z));
  
  //Setup of drawing
  translate(width / 2, height / 2);
  scale(5);
  stroke(255);
  noFill();
  
  angle.y += dt / 4;
  angle.x += dt / 8;
  angle.z -= dt / 16;
  rotateY(angle.y);
  rotateX(angle.x);
  rotateZ(angle.z);
  
  float hu = 0;
  beginShape();
  for(PVector p : points){
    stroke(hu, 255, 255);
    vertex(p.x, p.y, p.z);  
    hu += 0.1;
    if(hu > 255) hu = 0;
  }
  endShape();
  
  
  
}