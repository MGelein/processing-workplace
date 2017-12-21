int SCL = 2;

Game game;
Textures textures;
PGraphics stage;

void setup(){
  size(1280, 720);
  noSmooth();
  background(0);
  
  //Create the canvas to draw on
  stage = createGraphics(floor(width / SCL), floor(height / SCL));
  
  //Load all texture objects
  textures = new Textures();
  
  //The global game object
  game = new Game();
  
  //Load a font to use for all drawing of text
  textFont(createFont("Dawnlike/GUI/SDS_8x8.ttf", 8));
}

void draw(){
  //Do the rendering
  stage.beginDraw();
  stage.background(0);
  game.render(stage);
  stage.endDraw();
  
  //Do the updating
  game.update();
  
  //Now that we've drawn to the buffer, render it to screen
  image(stage, 0, 0, width, height);
}

void mousePressed(){ game.mouseDown(floor(mouseX / SCL), floor(mouseY / SCL)); }
void mouseReleased(){ game.mouseUp(floor(mouseX / SCL), floor(mouseY / SCL)); }

/**
KEY HANDLING
**/
Keys keys = new Keys();
class Keys{
  boolean[] keys = new boolean[256];
  
  void setState(int code, boolean state){
    keys[code] = state;
  }
  
  boolean isDown(int code){
    return keys[code] == true;
  }
  
  boolean isDownOnce(int code){
    if(keys[code] == true){
      keys[code] = false;
      return true;
    }
    return false;
  }
}

void keyPressed(){
  keys.setState(keyCode, true);
}

void keyReleased(){
  keys.setState(keyCode, false);
}