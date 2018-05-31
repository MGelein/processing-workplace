class Spot{
  int x;
  int y;
  float f = 0;
  float g = 0;
  float h = 0;
  ArrayList<Spot> neighbors = new ArrayList<Spot>();
  
  public Spot(int xPos, int yPos){
    x = xPos;
    y = yPos;
  }
  
  void show(color c){
    fill(c);
    noStroke();
    rect(x * wC, y * hC, wC - 1, hC - 1);
  }
  
  void addNeighbors(Spot[][] grid){
    if(x >= 1) neighbors.add(grid[x - 1][y]);
    if(x < cols - 1) neighbors.add(grid[x + 1][y]);
    if(x >= 1) neighbors.add(grid[x - 1][y]);
    
  }
}
