// The circle in the center of the screen
Circle circle;
// The player of the game
Player player;

/**
Entry point
**/
void setup(){
  //Set the size to 640x640 px
  size(640, 640);
  
  //Initialize the circle
  circle = new Circle(200);
  //Initialzie the player
  player = new Player(circle);
  
  //Set RectMode to center, and colorMode to HSB
  rectMode(CENTER);
  colorMode(HSB);
}

/**
Main Game loop
**/
void draw(){
  //Set background to black //<>//
  background(0);
  
  //Before any rendering, make 0, 0 the center of the screen
  translate(width / 2, height / 2);
  
  //Set the strokeWeight and color
  strokeWeight(3);
  stroke(player.jumps, 255, 255);
  fill(player.jumps, 255, 255, 255);
  
  //Do the update of the circle, and draw after that
  circle.update();
  circle.render();
  
  //Now update and render the player, no fill
  noFill();
  player.update();
  player.render();
}

/**
Catches any key events
**/
void keyPressed(){
  //Input is either up or spacebar
  if(keyCode == 32 || keyCode == 38){
    if(player.jump()){
      circle.spawnHurdle();
    }
  }
}

/**
Catches the release of the spacebar or up arrow
**/
void keyReleased(){
  //Set the keyDown to false to allow further jumping
  if(keyCode == 32 || keyCode == 38){ player.keyDown = false;}
}
