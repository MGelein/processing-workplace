class VWorld{
  ArrayList<VObj> objects = new ArrayList<VObj>();
  PVector gravity;
  float friction = 0.98f;
  
  VWorld(PVector gravity){
    this.gravity = gravity;
  }
  
  void addObj(VObj... obj){
    for(VObj o : obj) objects.add(o);
  }
  
  void update(){
    //Update all objects
    for(VObj o : objects){ o.update();}
    
    //Remove dead objects
    int i, max = objects.size();
    for(i = max - 1; i >= 0; i--){
      if(objects.get(i).dead) objects.remove(i);
    }
  }
  
  void show(){
    //Render all objects
    for(VObj o : objects){ o.show();}
  }
}