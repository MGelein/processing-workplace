class Game{
  
  int texCounter = 0;
  
  void update(){
    
  }
  
  /** Render using the provided graphics buffer */
  void render(PGraphics g){
    
    g.text("Long", 64, 16);
    g.image(textures.long_weapon.get(texCounter), 64, 32);
    
    g.text("Medium", 128, 16);
    g.image(textures.medium_weapon.get(texCounter), 128, 32);
    
    g.text("Short", 192, 16);
    g.image(textures.short_weapon.get(texCounter), 192, 32);
    
  }
  
  /** Called when the mouse is pressed. Passed coordinates are translated using game scale*/
  void mouseDown(int x, int y){
    texCounter ++;
  }
  
  /** Called when the mouse is released. Passed coordinates are translated using game scale*/
  void mouseUp(int x, int y){
    
  }
}