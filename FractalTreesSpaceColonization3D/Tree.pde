class Tree{
  int NUM_LEAVES = 1000;
  ArrayList<Leaf> leaves;
  ArrayList<Leaf> sprungLeaves = new ArrayList<Leaf>();
  ArrayList<Branch> branches;
  
  Tree(){
    createLeaves();
    createRoot();
  }
  
  void createRoot(){
    branches = new ArrayList<Branch>();
    
    PVector startDir = new PVector(0, -1);
    PVector startPos = new PVector(0, 600);
    Branch root = new Branch(startPos, startDir);
    
    branches.add(root);
    Branch current = root;
    
    //Go up to where leaves affect it
    while(! closeEnough(current)){
      Branch trunk = new Branch(current);
      branches.add(trunk);
      current = trunk;
    }
  }
  
  boolean closeEnough(Branch b){
    for(Leaf l : leaves){
      float d = PVector.dist(b.pos, l.pos);
      if(d < max_dist){
        return true;
      }
    }
    return false;
  }
  
  void createLeaves(){
    leaves = new ArrayList<Leaf>();
    for(int i = 0; i < NUM_LEAVES; i++){
      leaves.add(new Leaf());
    }
  }
  
  void show(){
    for(Leaf l : leaves){
      l.show();
    }
    for(Leaf l : sprungLeaves){
      l.show();
    }
    float sWeight;
    stroke(branches.get(1).brown);
    for(Branch b : branches){
      sWeight = map(branches.indexOf(b), 0, branches.size(), 10, 0);
      b.show(sWeight);
    }
  }
  
  void grow(){
    for(Leaf l : leaves){
      
      Branch closest = null;
      float record = max_dist;
      for(Branch b : branches){
        float d = PVector.dist(l.pos, b.pos);
        if(d < min_dist){
          l.reached();
          closest = null;//CHECK IF NEEDED
          break;
        }else if(d < record){
          closest = b;
          record = d;
        }
      }
      if(closest != null){
        PVector newDir = PVector.sub(l.pos, closest.pos);
        newDir.normalize();
        closest.dir.add(newDir);
        closest.count ++;
      }
    }
    
    //Check for deletion of reached leaves
    for(int i = leaves.size() - 1; i >= 0; i--){
      Leaf l = leaves.get(i);
      if(l.reached){
        leaves.remove(l);
        sprungLeaves.add(l);
      }
    }
    
    //Now check if branches need to branch
    ArrayList<Branch> newBranches = new ArrayList<Branch>();
    for(Branch b : branches){
      if(b.count > 0){
        //add random vector to break ties between leaves
        b.dir.add(PVector.random2D().mult(0.1));
        b.dir.div(b.count + 1);
        newBranches.add(new Branch(b));
        b.reset();
      }
    }
    branches.addAll(newBranches);
  }
}