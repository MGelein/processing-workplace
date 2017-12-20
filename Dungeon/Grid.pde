class Grid{
  ArrayList<PShape> shapes = new ArrayList<PShape>();
  GridCell[] cells;
  int rows;
  int cols;
  int scl = 32;
  
  Grid(int numRows, int numCols){
    rows = numRows;
    cols = numCols;
    cells = new GridCell[rows * cols];
    drawShapes();
    initGrid();
  }
  
  private void initGrid(){
    for(int i = 0; i < cells.length; i++){
      cells[i] = new GridCell(this, rowFromIndex(i), colFromIndex(i));
    }
  }
  
  void update(){
    for(GridCell c : cells){ c.update();}
  }
  
  void render(){
    noStroke();
    noFill();
    for(GridCell c : cells){ c.render();}
  }
 
  GridCell getCellFromCoords(float x, float z){
    return getCell(floor(z / scl), floor(x / scl));
  }
  
  GridCell getCell(int row, int col){
    return cells[row * cols + col];
  }
  GridCell getCell(int index){
    return cells[index];
  }
  
  private int rowFromIndex(int index){
    return floor(index / cols);
  }
  
  private int colFromIndex(int index){
    return index % cols;
  }
  
  void drawShapes(){
    PShape cube = createShape();
    cube.beginShape(QUADS);
    cube.noStroke();
    cube.noFill();
    cube.texture(textures.sheet);
    float s = scl / 2;
  
    // +Z "front" face
    cube.vertex(-s, -s,  s, 0, 0);
    cube.vertex( s, -s,  s, 1, 0);
    cube.vertex( s,  s,  s, 1, .5);
    cube.vertex(-s,  s,  s, 0, .5);
  
    // -Z "back" face
    cube.vertex( s, -s, -s, 0, 0);
    cube.vertex(-s, -s, -s, 1, 0);
    cube.vertex(-s,  s, -s, 1, .5);
    cube.vertex( s,  s, -s, 0, .5);
  
    // +Y "bottom" face
    //cube.vertex(-s,  s,  s, 0, 0);
    //cube.vertex( s,  s,  s, 1, 0);
    //cube.vertex( s,  s, -s, 1, .5);
    //cube.vertex(-s,  s, -s, 0, .5);
  
    // -Y "top" face
    cube.vertex(-s, -s, -s, 0, .5);
    cube.vertex( s, -s, -s, 1, .5);
    cube.vertex( s, -s,  s, 1, 1);
    cube.vertex(-s, -s,  s, 0, 1);
  
    // +X "right" face
    cube.vertex( s, -s,  s, 0, 0);
    cube.vertex( s, -s, -s, 1, 0);
    cube.vertex( s,  s, -s, 1, .5);
    cube.vertex( s,  s,  s, 0, .5);
  
    // -X "left" face
    cube.vertex(-s, -s, -s, 0, 0);
    cube.vertex(-s, -s,  s, 1, 0);
    cube.vertex(-s,  s,  s, 1, .5);
    cube.vertex(-s,  s, -s, 0, .5);

    cube.endShape();
    shapes.add(cube);
    
    PShape floor = createShape();
    floor.beginShape(QUADS);
    floor.noStroke();
    floor.noFill();
    floor.texture(textures.sheet);
    
    // -Y "top" face
    floor.vertex(-s, -s, -s, 0, 0);
    floor.vertex( s, -s, -s, 1, 0);
    floor.vertex( s, -s,  s, 1, .5);
    floor.vertex(-s, -s,  s, 0, .5);

    floor.endShape();
    shapes.add(floor);
  }
}