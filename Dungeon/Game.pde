class Game{
  
  Grid grid;
  
  Game(){
    grid = new Grid(64, 64);
  }
  
  void update(){
    grid.update();
  }
  
  void render(){
    grid.render();
  }
}