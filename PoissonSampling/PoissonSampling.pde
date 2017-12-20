float r = 10f;
int k = 30;
int n = 2; //amt of dimensions (2D for now)
float w = r / sqrt(n);
PVector[] grid;
ArrayList<PVector> active = new ArrayList<PVector>();
int cols;
int rows;

void setup(){
  size(400, 400);
  background(0);
  strokeWeight(4);
  
  //STEP 0
  cols = floor(width / w);
  rows = floor(height / w);
  grid = new PVector[cols * rows];
  for(int i = 0; i < cols * rows; i++){
    grid[i] = null;
  }
  
  //STEP 1
  //PVector pos = new PVector(random(width), random(height));
  PVector pos = new PVector(width / 2, 10);
  int i = floor(pos.x / w);
  int j = floor(pos.y / w);
  active.add(pos);
}

void draw(){
  background(0);
  //STEP 2
  if(active.size() > 0){
    PVector pos = active.get(floor(random(active.size())));
    boolean found = false;
    for(int n = 0; n < k; n++){
      //println("Try nr." + n);
      PVector sample = PVector.random2D();
      sample.setMag(random(r, 2 * r));
      sample.add(pos);
      
      int col = floor(sample.x / w);
      if(col < 0 || col >= cols) continue;
      int row = floor(sample.y / w);
      if(row < 0 || row >= rows) continue;
      
      boolean ok = true;
      for(int i = - 1; i <= 1; i++){
        for(int j = -1; j <= 1; j++){
          //println("Checking neighbor: " + i + ", " + j);
          int co = col + i;
          int ro = row + j;
          if(co < 0 || co >= cols || ro < 0 || ro >= rows) continue;
          PVector neighbor = grid[co + ro * cols];
          if(neighbor == null) continue;
          float d = PVector.dist(sample, neighbor);
          //println("Dist: " + d);
          if(d < r){
            //println("Too close");
            ok = false;
            break;
          }
        }
      }
      
      if(ok){
        grid[col + row * cols] = sample;
        active.add(sample);
        found = true;
      }   
      
    }
    if(!found){
      active.remove(pos);
    }
  }
  
  stroke(255);
  strokeWeight(4);
  for(PVector v : grid){
    if(v == null) continue;
    point(v.x, v.y);
  }
  
  stroke(255, 0, 255);
  for(PVector v : active){
    if(v == null) continue;
    point(v.x, v.y);
  }
}