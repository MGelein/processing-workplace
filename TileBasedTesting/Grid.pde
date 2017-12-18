class Grid{
  Cell[] cells;
  float scl = 10.0f;
  int rows;
  int cols;
  
  Grid(){
    rows = floor(height / scl);
    cols = floor(width / scl);
    
    cells = new Cell[cols * rows];
    for(int row = 0; row < rows; row++){
      for(int col = 0; col < cols; col++){
        cells[col + row * cols] = new Cell(this, row, col);
      }
    }
  }
  
  void show(){
    for(Cell c : cells) c.show();
  }
}