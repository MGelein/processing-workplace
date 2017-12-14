class Tree{
  int NUM_LEAVES = 500;
  ArrayList<Leaf> leaves;
  ArrayList<Branch> branches;
  
  Tree(){
    createLeaves();
    createRoot();
  }
  
  void createRoot(){
    branches = new ArrayList<Branch>();
    
    PVector startDir = new PVector(0, -1);
    PVector startPos = new PVector(width / 2, height);
    Branch root = new Branch(null, startPos, startDir);
    
    branches.add(root);
    Branch current = root;
    
    //Go up to where leaves affect it
    boolean found = false; float d;
    while(!found){
      for(Leaf l : leaves){
        d = PVector.dist(current.pos, l.pos);
        if(d < max_dist){
          found = true;
          break;
        }
        
        if(!found){
          Branch b = current.next();
          current = b;
          branches.add(current);
        }
      }
    }
  }
  
  void createLeaves(){
    leaves = new ArrayList<Leaf>();
    for(int i = 0; i < NUM_LEAVES; i++){
      leaves.add(new Leaf(new PVector(random(width), random(height - 100))));
    }
  }
  
  void show(){
    for(Leaf l : leaves){
      l.show();
    }
    for(Branch b : branches){
      b.show();
    }
  }
  
  void grow(){
    for(Leaf l : leaves){
      
      Branch closest = null;
      float record = max_dist;
      for(Branch b : branches){
        float d = PVector.dist(l.pos, b.pos);
        if(d < min_dist){
          l.reached = true;
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
      if(leaves.get(i).reached) leaves.remove(i);
    }
    
    //Now check if branches needd to branch
    ArrayList<Branch> newBranches = new ArrayList<Branch>();
    for(Branch b : branches){
      if(b.count > 0){
        b.dir.div(b.count);
        newBranches.add(b.next());
        b.reset();
      }
    }
    branches.addAll(newBranches);
  }
}