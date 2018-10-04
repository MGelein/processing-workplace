import processing.sound.*; //<>//
import java.lang.System;

// The circle in the center of the screen
Circle circle;
// The player of the game
Player player;
// The UI, mostly labels
UI ui;
// Sound manipulation object
Sound sound;

//Flag that holds if one of the inputs was pressed
boolean needsJump = false;
//If we are running the game
boolean runningGame = false;
//The global color variable
color gameColor;
//The strokeWeiht of the game
int gameWeight = 3;
// Amount of millis passed in last frame
int time = 0;
// Amount of alpha we want to have, this is for the fase effect
int targetAlpha = 150;
// The amount of alpha we have right now for the fase effect
float actualAlpha = 150;
//Values to make the screen shake
float yShake = 0;
float yOff = 0;
//Timeout value, as long as this is >0 no key input is accepted
int timeout = 0;

/**
 Entry point
 **/
void setup() {
  //Set the size to 1280 x 720 px
  size(1280, 720);
  //Set background to black
  background(0);

  //Initialize the sound
  sound = new Sound(this);
  //Initialize the circle
  circle = new Circle(height * .35f);
  //Initialzie the player
  player = new Player(circle);
  //Initialize the ui
  ui = new UI();

  //Set RectMode to center, and colorMode to HSB
  rectMode(CENTER);
  colorMode(HSB);
}

/**
 Main Game loop
 **/
void draw() {
  //Get time of this frame
  int t = millis();
  int delta = t - time;
  time = t;
    
  //Set background to black with alpha
  actualAlpha += (targetAlpha - actualAlpha) * 0.1;
  fill(color(0, 0, 0, actualAlpha));
  noStroke();
  rect(0, 0, width * 2, height * 2);
  
  //Before any rendering, make 0, 0 the center of the screen, or slightly lower
  translate(width / 2, height / 2 + player.radius + yOff);
  yOff += yShake;
  yShake *= 0.99f;
  yOff *= 0.6f;

  //Set the gameColor
  gameColor = color(player.jumps, 255, 255);

  //Set the strokeWeight and color
  strokeWeight(gameWeight);
  stroke(gameColor);
  fill(gameColor);
  
  //First render the FFT, but do it without yOffset
  translate(0, -yOff);
  sound.render();
  translate(0, yOff);


  //Render, but not update outside of game
  circle.render();
  player.render();

  //Only update the game if we need to do it
  if (runningGame) {
    //If we're running render the score
    ui.renderScore();
    //Do the update of the circle, and draw after that, also pass amount of time passed since last frame
    circle.update(((delta * 1.0f) / 1000f));

    //Now update and render the player, no fill
    player.update();

    //Check if we need to jump
    if (needsJump) {
      needsJump = false;
      if (player.jump()) {
        circle.spawnHurdle();
      }
    }

    //Now do collision check and break out of game if necessary
    if (circle.collision(player)) {
      runningGame = false;
      timeout = 200;
      sound.startMenu();
      registerScore();
    }
  } else {
    //Decrease timeout if it is over 0
    if(timeout > 0){
      timeout--;
      ui.renderScore();
    }else{
      //If we're not running, show the play cue
      ui.renderCue();
    }
  }
}

//(RE)starts the game
void startGame() {
  player.init();
  circle.init();
  runningGame = true;
}

/**
 Catches any key events
 **/
void keyPressed() {
  //Implement timeout
  if(timeout > 0) return;
  //If we have not yet started, start now
  if (!runningGame) {
    startGame();
    return;
  }
  //Input is either up or spacebar
  if (keyCode == 32 || keyCode == 38) {
    needsJump = true;
  }
  
  //Use escape to exit
  if(key == ESC){
    exit();
  }
}
/**
 Catches any mouse press
 **/
void mousePressed() {
  //Implement timeout
  if(timeout > 0) return;
  //If we have not yet started, start now
  if (!runningGame) {
    startGame();
    return;
  }
  //If you press the mouse, jump!
  needsJump = true;
}

/**
 Catches any mouse release
 **/
void mouseReleased() {
  //Now release the input
  player.keyDown = false;
}

/**
 Catches the release of the spacebar or up arrow
 **/
void keyReleased() {
  //Set the keyDown to false to allow further jumping
  if (keyCode == 32 || keyCode == 38) { 
    player.keyDown = false;
  }
}

//Returns the username of the user currently logged on
String getUserName(){
  return System.getProperty("user.name");
}
