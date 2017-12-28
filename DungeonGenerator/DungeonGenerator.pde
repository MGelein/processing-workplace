//CONSTANTS
int SIZE = 4;
int WALL = 0;
int FLOOR = 1;

int[] grid;
int cols;
int rows;

void setup(){
  size(404, 404);
  
  cols = floor(width / SIZE);
  rows = floor(height / SIZE);
  grid = new int[cols * rows];
  for(int i = 0; i < grid.length; i++){
    grid[i] = (random(1) > .5f) ? WALL : FLOOR;
  }
}

void draw(){
  
  //Draw all cells
  noStroke();
  for(int i = 0; i < grid.length; i++){
    setPixel(i % cols, floor(i / cols), (grid[i] == WALL) ? color(0): color(255));
  }
}

void setPixel(int x, int y, int c){
  fill(c);
  rect(x * SIZE, y * SIZE, SIZE, SIZE);
}