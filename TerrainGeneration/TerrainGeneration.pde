int cols,rows;
int scl = 20;
int w = 2000;
int h = 1600;
float grain = 0.1f;
float minHeight = 10f;
float ampHeight = 200f;
float zHeight;
float flying = 0;
int yellow = color(239, 221, 111);
int grey = color(100, 100, 100);


float[][] terrain;
  
void setup(){
  size(600, 600, P3D);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
}

void draw(){
  lights();
  float terrainFactor = sin(flying / 100);
  zHeight = (abs(terrainFactor) * ampHeight) + minHeight;
  
  flying -= 0.1;
  float yOff = flying;
  for(int y = 0; y < rows; y++){
    float xOff = 0;
    for(int x = 0; x < cols; x++){
      terrain[x][y] = map(noise(xOff, yOff), 0, 1, -zHeight, zHeight);
      xOff += grain;
    } 
    yOff += grain;
  }
  
  
  background(color(126, 192, 238));
  //stroke(255);
  noStroke();
  fill(lerpColor(yellow, grey, abs(terrainFactor)));
  
  translate(width / 2, height / 2 + 50 + (abs(terrainFactor) * 50));
  rotateX(PI / 3);
  
  translate(-w / 2, -h / 2);
  for(int y = 0; y < rows - 1; y++){
    beginShape(TRIANGLE_STRIP);
    for(int x = 0; x < cols; x++){
      vertex(x * scl,y * scl, terrain[x][y]);
      vertex(x * scl,y * scl + scl, terrain[x][y + 1]);
    }
    endShape();
  }
}