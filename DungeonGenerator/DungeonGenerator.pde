//CONSTANTS
int SIZE = 4;
int WALL = 0;
int FLOOR = 1;
int ROOM = 2;
int CONN = 3;
int ROOM_DENSITY = 300;
int MAX_ROOM_SIZE = 13;
int MIN_ROOM_SIZE = 5;

int[] grid;
int cols;
int rows;
ArrayList<Int2D> stack = new ArrayList<Int2D>();
  

void setup(){
  size(404, 404);
  
  cols = floor(width / SIZE);
  rows = floor(height / SIZE);
  grid = new int[cols * rows];
  for(int i = 0; i < grid.length; i++){
    grid[i] = WALL;
  }
  
  //Step 1, give it ROOM_DENSITY tries to place rooms
  int tries = 0;
  while(tries < ROOM_DENSITY){
    tries++;
    placeRoom();
  }
  
  //Step 2, pick a random wall at an uneven starting point, push to stack
  Int2D pos = new Int2D();
  do{
    pos.rndOdd(cols, rows);
  } while(grid[pos.x + pos.y * cols] != WALL);
  grid[pos.x + pos.y * cols] = FLOOR;
  stack.add(pos);
  
  //Step 3, tunnel randomly from there while there are items on the stack
  ArrayList<Int2D> neighbors = new ArrayList<Int2D>();
  while(stack.size() > 0){
    int rndIndex = stack.size() - 1;
    //Grab the first element from the stack
    pos = stack.get(rndIndex);
    //Try to find a neighbor
    neighbors = getNeighbors(pos);
    //IF no neighbors, this is a dead end, remove this cell from the stack
    if(neighbors.size() == 0){
      stack.remove(rndIndex);
    }else{//Connect to a random neighbor and add that neighbor to the stack
      Int2D rndNeighbor = neighbors.get(floor(random(neighbors.size())));
      stack.add(rndNeighbor);
      //Set the path to floor
      grid[rndNeighbor.x + rndNeighbor.y * cols] = FLOOR;
      int midX = (rndNeighbor.x + pos.x) / 2;
      int midY = (rndNeighbor.y + pos.y) / 2;
      grid[midX + midY * cols] = FLOOR;
    }
  }
  
  //Step 4, find all connectors
  for(int i = 0; i < grid.length; i++){
    
  }
  
}

void draw(){
  //Draw all cells
  noStroke();
  for(int i = 0; i < grid.length; i++){
    setPixel(i % cols, floor(i / cols), getColor(grid[i]));
  }
}

ArrayList<Int2D> getNeighbors(Int2D pos){
  ArrayList<Int2D> n = new ArrayList<Int2D>();
  //Try all sides
  Int2D left = new Int2D(pos.x - 2, pos.y);
  Int2D right = new Int2D(pos.x + 2, pos.y);
  Int2D up = new Int2D(pos.x, pos.y - 2);
  Int2D down = new Int2D(pos.x, pos.y + 2);
  //Add them to the list of possible if they are in screen
  if(left.x > 0) n.add(left);
  if(right.x < cols) n.add(right);
  if(up.y > 0) n.add(up);
  if(down.y < rows) n.add(down);
  //Check if they are surrounded by WALL
  for(int i = n.size() - 1; i >= 0; i--){
    if(!isAllWall(n.get(i))) n.remove(i);
  }
  return n;
}

boolean isAllWall(Int2D p){
  for(int x = p.x - 1; x < p.x + 1; x ++){
    for(int y = p.y - 1; y < p.y + 1; y ++){
      if(grid[x + y * cols] != WALL) return false;
    }
  }
  return true;
}


int getColor(int tileType){
  if(tileType == WALL) return color(0);
  if(tileType == FLOOR) return color(255);
  if(tileType == ROOM) return color(200);
  if(tileType == CONN) return color(120);
  return color(255, 0, 0);
}

void setPixel(int x, int y, int c){
  fill(c);
  rect(x * SIZE, y * SIZE, SIZE, SIZE);
}

void placeRoom(){
  //random x and y coordinate
  Int2D pos = new Int2D();
  pos.rndOdd(cols, rows);
  //random width and height, between max and min room size
  Int2D dim = new Int2D();
  dim.rndOdd(MIN_ROOM_SIZE, MAX_ROOM_SIZE, MIN_ROOM_SIZE, MAX_ROOM_SIZE);
  //Make sure we are not outside of bounds
  if(pos.x + dim.x >= cols) return;
  if(pos.y + dim.y >= rows) return;
  
  //Now check if any of our tiles intersect with other floor tiles
  for(int i = pos.x; i < pos.x + dim.x; i++){
    for(int j = pos.y; j < pos.y + dim.y; j++){
      if(grid[i + j * cols] != WALL){
        //Found a intersecting floor, return
        return;
      }
    }
  }
  
  //If we made it this far, add the room to the dungeon
  for(int i = pos.x; i < pos.x + dim.x; i++){
    for(int j = pos.y; j < pos.y + dim.y; j++){
      grid[i + j * cols] = ROOM;
    }
  }
}

class Int2D{
  int x;
  int y;
  Int2D(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  Int2D(){
    x = y = 0;
  }
  
  void rndOdd(int minX, int maxX, int minY, int maxY){
    x = floor(random(minX, maxX - 1));
    y = floor(random(minY, maxY - 1));
    //make sure that the coords are odd
    x = (x % 2 == 0) ? x + 1: x;
    y = (y % 2 == 0) ? y + 1: y;
  
  }
  
  void rndOdd(int maxX, int maxY){
    rndOdd(0, maxX, 0, maxY);
  }
}