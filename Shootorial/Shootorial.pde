ImageLoader imageLoader;
KeyListener keyListener;
Game game;

void setup(){
  size(640, 360);
  colorMode(HSB);
  
  imageLoader = new ImageLoader();
  imageLoader.load();
  
  keyListener = new KeyListener();
  
  game = new Game();
}

void draw(){
  background(255);
  
  game.update();
  
  game.show();
}

void keyPressed(){
  keyListener.setDown(keyCode);
}

void keyReleased(){
  keyListener.setUp(keyCode);
}