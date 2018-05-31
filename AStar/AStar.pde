int cols = 5;
int rows = 5;
Spot[][] grid = new Spot[cols][rows];
ArrayList<Spot> open = new ArrayList<Spot>();
ArrayList<Spot> closed = new ArrayList<Spot>();

Spot start;
Spot end;

float wC;
float hC;

void setup(){
  size(400, 400);
  //Create all the spots
  for(int x = 0; x < cols; x++){
    for(int y = 0; y < rows; y++){
      grid[x][y] = new Spot(x, y);
    }
  }
  
  start = grid[0][0];
  end = grid[cols - 1][rows - 1];
  
  open.add(start);
  
  wC = width / cols;
  hC = height / rows;
}

void draw(){
  if(open.size() > 0){
    //Find the lowest cost openSet
    Spot winner = open.get(0);
    for(Spot spot : open){
      if(spot.f < winner.f){
        winner = spot;
      }
    }
    
    Spot current = winner;
    
    if(winner == end){//We foudn the end
      println("DONE");
    }
    
    closed.add(current);
    open.remove(current);
    
    
  }else{
    //No solution
  }
  
  //Draw all the spots
  for(Spot[] row : grid){
    for(Spot spot: row){
      spot.show(color(255));
    }
  }
  
  
  for(Spot spot : closed){
    spot.show(color(255, 0, 0));
  }
  
  for(Spot spot : open){
    spot.show(color(0, 255, 0));
  }
  
}
