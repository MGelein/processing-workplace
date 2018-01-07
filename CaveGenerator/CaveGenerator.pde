int SCL = 8;
int cols;
int rows;
int[] grid;

int WALL = 0;
int FLOOR = 1;
int CONN = 2;

//use cycles: 2 and startAlivechance 0.4 for rough caves
//generally: higher cycles is smoother openenr and larger caves
//roughener: Small chance to flip a cell from wall to floor and vice versa

int cycles = 2;                    //2
int deathLimit = 3;                //3
int birthLimit = 3;                //3
float startAliveChance = 0.4f;     //.4f
float roughener = -1.0f;           //-1.0f;

void setup(){
  size(1600, 400);
  cols = floor(width / SCL);
  rows = floor(height / SCL);
  generate();
}
  
void generate(){
  grid = new int[cols * rows];
  for(int x = 0; x < cols; x++){
    for(int y = 0; y < rows; y++){
      grid[x + y * cols] = (random(1) < startAliveChance) ? FLOOR : WALL;
    }
  }
  
  //Now set all sides to black
  for(int x = 0; x < cols; x++){
    setCell(x, 0, WALL);
    setCell(x, rows - 1, WALL);
  }
  for(int y = 0; y < rows; y++){
    setCell(0, y, WALL);
    setCell(cols - 1, y, WALL);
  }
  
  //then cycle the alogrithm a few times
  for(int i = 0; i < cycles; i++) cycle();
  
  //Now only keep connected cells
  keepConnected(0);
}

void keepConnected(int tryCount){
  int[] connectedGrid = new int[cols * rows];
  int amtFloor = 0;
  for(int i = 0; i < grid.length; i++){
    connectedGrid[i] = grid[i];
    if(grid[i] == FLOOR) amtFloor ++;
  }
  //First get random FLOOR startCell
    int startCell = floor(random(grid.length));
  while(grid[startCell] == WALL){
    startCell = floor(random(grid.length));
  }
  
  //Then floodfill
  ArrayList<Integer> open = new ArrayList<Integer>();
  int count = 0;
  open.add(startCell);
  while(open.size() > 0){
    //Pick the first cell of the last
    int cell = open.get(0);
    int x = cell % cols;
    int y = floor(cell / cols);
    int left = x - 1 + y * cols;
    int right = x + 1 + y * cols;
    int down = x + (y + 1) * cols;
    int up = x + (y - 1) * cols;
    if(left > 0 && left <= grid.length - 1 && connectedGrid[left] == FLOOR) {
      connectedGrid[left] = CONN;
      open.add(left);
    }
    if(right > 0 && right <= grid.length - 1 && connectedGrid[right] == FLOOR) {
      connectedGrid[right] = CONN;
      open.add(right);
    }
    if(up > 0 && up <= grid.length - 1 && connectedGrid[up] == FLOOR){
      connectedGrid[up] = CONN;
      open.add(up);
    }
    if(down > 0 && down <= grid.length - 1 && connectedGrid[down] == FLOOR){
      connectedGrid[down] = CONN;
      open.add(down);
    }
    
    count ++;
    //Now that we're done with it, remove from open list
    open.remove(0);
  }
  
  //If this area is too small, try again, this was a bad starting point
  if(count < amtFloor / 3) {
    if(tryCount > 100){//If we tried a 100 different points, please generate something else
      generate();
      return;
    }
    keepConnected(tryCount + 1);
    return;
  }
  
  //Else if we make it to here, we can rewrite the grid
  for(int i = 0; i < grid.length; i++){
    if(connectedGrid[i] == CONN) grid[i] = FLOOR;
    else grid[i] = WALL;
  }
}

void mousePressed(){generate();}

void draw(){
  background(0);
  noStroke();
  
  for(int x = 0; x < cols; x++){
    for(int y = 0; y < rows; y++){
      drawPixel(x, y, grid[x + y * cols]);
    }
  }
}

void cycle(){
  int[] temp = new int[cols * rows];
  for(int i = 0; i < grid.length - cols; i++){
    int x = i % cols;
    int y = floor(i / cols);
    int tl = getCell(x - 1, y - 1);
    int tm = getCell(x, y - 1);
    int tr = getCell(x + 1, y - 1);
    int ml = getCell(x - 1, y);
    int mm = getCell(x, y);
    int mr = getCell(x + 1, y);
    int bl = getCell(x - 1, y + 1);
    int bm = getCell(x, y + 1);
    int br = getCell(x + 1, y + 1);
    int neighbors = tl + tm + tr + ml + mr + bl + bm + br;
    if(mm == FLOOR){
      temp[i] = (neighbors < deathLimit) ? WALL : FLOOR;
      //if(neighbors >= 4) temp[i] = WALL;//Overpopulation
      //else if(neighbors <= 1) temp[i] = WALL;//Isolation
      //else temp[i] = FLOOR;
    }else if(mm == WALL){
      temp[i] = (neighbors > birthLimit) ? FLOOR : WALL;
      //if(neighbors == 3) temp[i] = FLOOR;//Birth
    }
    
    //Small chance for a cell to become alive or dead
    if(random(1) < roughener) temp[i] = temp[i] == WALL ? FLOOR : WALL;
  }
  grid = temp;
}

int getCell(int x, int y){
  if(x < 0 || x >= cols) return WALL;
  if(y < 0 || y >= rows) return WALL;
  return grid[x + y * cols];
}

void setCell(int x, int y, int val){
  if(x < 0 || x >= cols) return;
  if(y < 0 || y >= rows) return;
  grid[x + y * cols] = val;
}

void drawPixel(int x, int y, int type){
  fill(type == FLOOR ? 255 : 0);
  rect(x * SCL, y * SCL, SCL, SCL);
}