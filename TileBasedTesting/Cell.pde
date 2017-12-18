class Cell{
  Grid grid;
  int row;
  int col;
  
  Cell(Grid grid, int row, int col){
    this.row = row;
    this.col = col;
    this.grid = grid;
  }
  
  void show(){
    noFill();
    stroke(255);
    rect(col * grid.scl, row * grid.scl, grid.scl, grid.scl);
  }
}