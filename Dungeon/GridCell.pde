class GridCell{
  int row;
  int col;
  int dep;
  PVector pos = new PVector();
  Grid grid;
  
  GridCell(Grid g, int numRow, int numCol){
    grid = g;
    row = numRow;
    col = numCol;
    dep = (random(1) > .5f) ? 1 : 0;
  }
    
  void update(){
    pos.x = col * grid.scl;
    pos.y = dep * grid.scl;
    pos.z = row * grid.scl;
  }
  
  void toggleDepth(){
    dep = dep == 0 ? 1 : 0;
  }
  
  void render(){
    if(!cam.isVisible(pos)) return;
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    shape(grid.shapes.get((dep == 0) ? 0 : 1));    
    popMatrix();
  }
}