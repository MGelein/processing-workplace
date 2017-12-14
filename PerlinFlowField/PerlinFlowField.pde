float inc = 0.1;
int scl = 20;
int cols, rows; 
ArrayList<Particle> particles = new ArrayList<Particle>();
PVector[] flowfield = new PVector[cols * rows];
int numParticles = 500;

PVector noiseOff = new PVector();

void setup(){
  size(960, 540);
  cols = floor(width / scl);
  rows = floor(height / scl);
  
  while(numParticles > 0){
    numParticles --;
    particles.add(new Particle());
  }
}

void draw(){
  background(255);
  
  noiseOff.y = 0;
  float angle = 0.0f;
  for(int y = 0; y < rows; y++){
    noiseOff.x = 0.0f;
    for(int x = 0; x < cols; x++){
      angle = noise(noiseOff.x, noiseOff.y, noiseOff.z) * TWO_PI;
      PVector v = PVector.fromAngle(angle);
      flowfield[x + y * cols] = v;
      noiseOff.x += inc;
      stroke(0);
      strokeWeight(1);
      pushMatrix();
      translate(x * scl, y * scl);
      rotate(v.heading());
      line(0, 0, scl, 0);
      popMatrix();
    }
    noiseOff.y += inc;
  }
  noiseOff.z += inc / 10;
  
  for(Particle p : particles){
    p.update();
    p.show();
    p.applyForce(flowfield[p.getFFIndex()]);
  }
}