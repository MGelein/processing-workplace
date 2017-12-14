Cell[][] grid;
Cell[][] next;

float dA = 1.0;
float dB = 0.5;
float feed = 0.055;
float k = 0.062;

void setup(){
  size(400, 400);
  pixelDensity(1);
  grid = new Cell[width][height];
  next = new Cell[width][height];
  //frameRate(2);
  
  for(int x = 0; x < width; x++){
     for(int y = 0; y < height; y++){
       grid[x][y] = new Cell(1, 0);
       next[x][y] = new Cell(1, 0);
     }
  }
  
  for(int i = 200; i < 300; i++){
    for(int j = 200; j < 300; j++){
      grid[i][j].b = 1;  
    }
  }
  
}

void draw(){
  background(51);
  
  loadPixels();
  int c; float a; float b;
  for(int x = 1; x < width - 1; x++){
     for(int y = 1; y < height - 1; y++){
       a = grid[x][y].a;
       b = grid[x][y].b;
       next[x][y].a = a +
                      (dA * laplaceA(x, y)) - 
                      (a * b * b) +
                      (feed * (1 - a));
       next[x][y].b = b +
                      (dB * laplaceB(x, y)) - 
                      (a * b * b) -
                      ((k + feed) * b);
       next[x][y].a = constrain(next[x][y].a, 0, 1);
       next[x][y].b = constrain(next[x][y].b, 0, 1);
       
       float ratio = grid[x][y].a - grid[x][y].b;
       pixels[x + y * width] = color(255 * ratio);
     }
  }
  
  updatePixels();
  
  swap();
}

float laplaceA(int x, int y){
  float sumA = 0;
  
  sumA += grid[x][y].a * -1;
  sumA += grid[x - 1][y].a * .2;
  sumA += grid[x + 1][y].a * .2;
  sumA += grid[x][y - 1].a * .2;
  sumA += grid[x][y + 1].a * .2;
  sumA += grid[x - 1][y - 1].a * .05;
  sumA += grid[x + 1][y + 1].a * .05;
  sumA += grid[x + 1][y - 1].a * .05;
  sumA += grid[x - 1][y + 1].a * .05;
  
  return sumA;
}


float laplaceB(int x, int y){
  float sumB = 0;
  
  sumB += grid[x][y].b * -1;
  sumB += grid[x - 1][y].b * .2;
  sumB += grid[x + 1][y].b * .2;
  sumB += grid[x][y - 1].b * .2;
  sumB += grid[x][y + 1].b * .2;
  sumB += grid[x - 1][y - 1].b * .05;
  sumB += grid[x + 1][y + 1].b * .05;
  sumB += grid[x + 1][y - 1].b * .05;
  sumB += grid[x - 1][y + 1].b * .05;
  
  return sumB;
}

void swap(){
  Cell[][] temp = grid;
  grid = next;
  next = temp;
}