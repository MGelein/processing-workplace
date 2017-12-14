class Cell{
  int row;
  int col;
  float top;
  float right;
  float bottom;
  float left;
  boolean visited;
  boolean[] walls;
  
  Cell(int row, int col){
    this.row = row;
    this.col = col;
    top = row * SIZE;
    bottom = top + SIZE;
    left = col * SIZE;
    right = left + SIZE;
    walls = new boolean[]{true, true, true, true};
    visited = false;
  }
  
  Cell checkNeighbors(){
     Cell[] neighbors = new Cell[]{
         getCellAt(row - 1, col), getCellAt(row, col + 1), 
         getCellAt(row + 1, col), getCellAt(row, col - 1)};
     
     int valid = 0;
     for(Cell c : neighbors) if(c != null) valid++;
     
     Cell[] unvisited = new Cell[valid];
     valid = 0;
     for(Cell c : neighbors){
       if(c != null && !c.visited){
         unvisited[valid] = c;
         valid++;
       }
     }
     
     if(valid > 0){
       return unvisited[int(random(0, valid))];
     }else{
       return null;
     }
  }
  
  void show(){
    noFill();
    stroke(255);
    
    if(walls[0]) line(left, top, right, top);
    if(walls[1]) line(right, top, right, bottom);
    if(walls[2]) line(right, bottom, left, bottom);
    if(walls[3]) line(left, bottom, left, top);
    
    if(visited){
      noStroke();
      fill(255, 0, 255, 100);
      rect(left, top, SIZE, SIZE);
    }
  }
}