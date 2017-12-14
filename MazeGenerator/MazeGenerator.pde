Cell[] cells;
int SIZE = 40;

int W_TOP = 1;
int W_RIGHT = 2;
int W_BOTTOM = 4;
int W_LEFT = 8;

int cols;
int rows;

Cell current;

void setup(){
  size(400, 400);
  frameRate(2);
  
  cols = int(width / SIZE);
  rows = int(height / SIZE);
  cells = new Cell[cols * rows];
  for(int i = 0; i < rows; i++){
     for(int j = 0; j < cols; j++){
       cells[i + j * cols] = new Cell(i, j);
     }
  }
  
  current = cells[0];
}

void draw(){
  background(51);
  
  for(Cell c : cells){
    c.show();
  }
  
  //STEP 1
  current.visited = true;
  Cell next = current.checkNeighbors();
  if(next != null){
    //STEP 2
    removeWalls(current, next);
    
    //STEP 4
    current = next;
    next.visited = true;
  }
}

void removeWalls(Cell a, Cell b){
  int dRow = a.row - b.row;
  if(dRow == 1){
     a.walls[1] = b.walls[3] = false; 
  }else if(dRow == -1){
     a.walls[3] = b.walls[1] = false; 
  }
}

Cell getCellAt(int i, int j){
  if(i < 0 || j < 0 || i >= rows || j >= cols) return null;
  return cells[i + j * cols];
}