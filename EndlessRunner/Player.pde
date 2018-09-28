/**
 The player class, renders, and updates the player
 **/
class Player {
  //Reference to the circle
  Circle circle;
  //The position along the y-axis
  float y;
  //velocity along the y-axis
  float yVel = 0;
  /**Sets the jump force*/
  float force = 10;
  //The size of the player
  float radius = 10;
  //The floor level
  float yMax;
  //Test to prevent jumping without letting go
  boolean keyDown = false;
  /**Amount of jumps the player has taken*/
  int jumps = 0;
  // The score of the player
  int score = 0;

  /**
   Creates a new player with a reference to the circle
   **/
  public Player(Circle c) {
    //Set ref to circle and calc player height
    circle = c;
    radius = c.radius / 10;
    //Slightly above the surface
    yMax = -c.radius + radius;
    y = yMax - radius;
    //Init player
    init();
  }

  /**
   Reset to starting condition
   **/
  void init() {
    jumps = 0;
    yVel = 0;
    y = yMax;
    score = 0;
    keyDown = false;
    update();
    //Now also start playing menumusic
    sound.startMenu();
  }

  //Update applies a little bit of physics
  void update() {
    //Update the yMax, incase circle has changed
    yMax = -circle.radius - radius;
    //Increase y-velocity
    yVel += .3f;
    //Also apply friction to velocity
    yVel *= 0.95f;
    //Now add velocity to position
    y += yVel;
    //Check if we're not going through the ground
    if (y > yMax) {
      y = yMax;
      //No bounce, since this screws with precision
      yVel = 0;
    }
  }

  /**
   Renders the player
   **/
  void render() {
    //Now draw the player
    ellipse(0, y, radius * 2, radius * 2);
  }
  
  /**
  Amount of degrees of the circle that are considered 'dangerous'
  **/
  float getSpread(){
    //Radius times two, cause we need the angle spread of the diameter, not radius of the player
    return ((radius * 2 + 3) / (abs(TWO_PI * y))) * 360;
  }

  /**
   Makes the player jump
   **/
  boolean jump() {
    //Ignore if already falling or jumping, or key is still down
    if (yVel != 0 || y != yMax || keyDown) return false;
    //Set the velocity to be negative (i.e. up)
    yVel = -force;
    //And set the keyDown
    keyDown = true;
    //Increase number of jumps
    jumps++;
    //Return true to signify succesful jump
    return true;
  }
}
