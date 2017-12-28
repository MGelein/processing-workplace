//CONSTANTS
int SIZE = 16;
int WALL = 0;
int FLOOR = 1;
int ROOM = 2;
int VOID = 3;
int ROOM_DENSITY = 500;
float DEAD_ROOM_CHANCE = 0.5f;
int MAX_ROOM_SIZE = 13;
int MIN_ROOM_SIZE = 5;

int[] grid;
int cols;
int rows;
ArrayList<Room> rooms;
  

void setup(){
  size(816, 816);
  
  cols = floor(width / SIZE);
  rows = floor(height / SIZE);
  generate();
}

void draw(){
  background(0);
  //Draw all cells
  noStroke();
  for(int i = 0; i < grid.length; i++){
    setPixel(i % cols, floor(i / cols), getColor(grid[i]));
  }
}

void mousePressed(){
  generate();
}

boolean isDeadEnd(int x, int y){
  if(x < 1 || x >= cols - 1 || y <  1 || y >= rows - 1) return false;
  int count = 0;
  if(grid[x - 1 + y * cols] == WALL) count ++;
  if(grid[x + 1 + y * cols] == WALL) count ++;
  if(grid[x + (y - 1) * cols] == WALL) count ++;
  if(grid[x + (y + 1) * cols] == WALL) count ++;
  if(count >= 3) return true;
  return false;
}

void generate(){
  //Step 0, set everything as solid walls
  grid = new int[cols * rows];
  for(int i = 0; i < grid.length; i++){
    grid[i] = WALL;
  }
  rooms = new ArrayList<Room>();
  
  //Step 1, give it ROOM_DENSITY tries to place rooms
  int tries = 0;
  while(tries < ROOM_DENSITY){
    tries++;
    placeRoom();
  }
  
  //Step 2, pick a random wall at an uneven starting point, push to stack
  ArrayList<Int2D> stack = new ArrayList<Int2D>();
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
  
  //Step 4, for every room, punch a hole to the path
  for(Room r : rooms){
    r.punchHoles();
  }
  
  //Step 5, randomly remove some walls
  for(int i = 0; i < grid.length; i++){
    int x = i % cols;
    int y = floor(i / cols);
    if(grid[i] == WALL && x > 0 && x <= cols - 2 && y > 0 && y <= rows -2){
      if(isStraightWall(x, y)){
        if(random(1) < 0.02f) grid[i] = FLOOR;
      }
    }
  }
  
  //Step 6, remove dead ends
  int found;
  do{
    found = 0;
    for(int i = 0; i < grid.length; i++){
      if(grid[i] == FLOOR){//On floors, check if they are a dead end
        int x = i % cols;
        int y = floor(i / cols);
        if(isDeadEnd(x, y)){
          found ++;
          grid[i] = WALL;
        }
      }
    }
  }while(found > 0);
  
  //Step 7: For all pure walls cells, turn them into void
  ArrayList<Integer> voids = new ArrayList<Integer>();
  for(int i = 0; i < grid.length; i++){
    pos = new Int2D(i % cols, floor(i / cols));
    if(getCell(pos.x, pos.y) == WALL){
      int left = getCell(pos.x - 1, pos.y);
      int tl = getCell(pos.x - 1, pos.y - 1);
      int right = getCell(pos.x + 1, pos.y);
      int tr = getCell(pos.x + 1, pos.y - 1);
      int up = getCell(pos.x, pos.y - 1);
      int bl = getCell(pos.x - 1, pos.y + 1);
      int down = getCell(pos.x, pos.y + 1);
      int br = getCell(pos.x + 1, pos.y + 1);
      if(left == WALL && right == WALL && up == WALL && down == WALL && tl == WALL
        && tr == WALL && br == WALL && bl == WALL){
        voids.add(i);
      }
    }
  }
  for(int i : voids){
    grid[i] = VOID;
  }
}

boolean isStraightWall(int x, int y){
  int left = getCell(x - 1, y);
  int right = getCell(x + 1, y);
  int up = getCell(x, y - 1);
  int down = getCell(x, y + 1);
  if(left == right && left == WALL && up == FLOOR && down == FLOOR){
    return true;
  }else if(up == down && up == WALL && left == FLOOR && right == FLOOR){
    return true;
  }
  return false;
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
      if(getCell(x, y) != WALL) return false;
    }
  }
  return true;
}

int getCell(int x, int y){
  if(x < 0 || x >= cols || y < 0 || y >= rows) return WALL;
  return grid[x + y * cols];
}


int getColor(int tileType){
  if(tileType == WALL) return color(0);
  if(tileType == FLOOR) return color(255);
  if(tileType == ROOM) return color(200);
  if(tileType == VOID) return color(125, 0, 125);
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
  
  Room room = new Room();
  rooms.add(room);
  
  //If we made it this far, add the room to the dungeon
  for(int i = pos.x; i < pos.x + dim.x; i++){
    for(int j = pos.y; j < pos.y + dim.y; j++){
      grid[i + j * cols] = ROOM;
      room.tiles.add(new Int2D(i, j));
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
  
  boolean isOdd(){
    return (x % 2 != 0) && (y % 2 != 0);
  }
}

class Room{
  ArrayList<Int2D> tiles = new ArrayList<Int2D>();
  
  void setAllFloor(){
    for(Int2D p : tiles){
      grid[p.x + p.y * cols] = FLOOR;
    }
  }
  
  void punchHoles(){
    punchHole();
    //25% percent chance for more exits
    while(random(1) < (1 - DEAD_ROOM_CHANCE)){
      punchHole();
    }
    setAllFloor();
  }
  
  void punchHole(){
    //Pick a random odd spot in the room
    Int2D pos;
    do{
      pos = rndTile();
    }while(!pos.isOdd());
    //Pick a random direction
    pos = new Int2D(pos.x, pos.y);
    Int2D dir = new Int2D();
    int rnd = floor(random(4));
    if(rnd == 0) dir.x  = -1;
    if(rnd == 1) dir.x  = 1;
    if(rnd == 2) dir.y  = -1;
    if(rnd == 3) dir.y  = 1;
    
    //Punch through untill we reach FLOOR
    int newX = pos.x + dir.x;
    int newY = pos.y + dir.y;
    do{
      grid[newX + newY * cols] = FLOOR;
      pos.x = newX;
      pos.y = newY;
      newX += dir.x;
      newY += dir.y;
      //If we reach an edge
      if(newX < 1 || newX >= cols -1 || newY < 1 || newY >= rows - 1){
        //Try again
        punchHole();
        return;        
      }
    }while(grid[newX + newY * cols] != FLOOR);
  }
  
  Int2D rndTile(){
    return tiles.get(floor(random(tiles.size())));
  }
}