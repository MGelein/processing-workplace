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
  float radius = 20;
  //The floor level
  float yMax;
  //Test to prevent jumping without letting go
  boolean keyDown = false;
  /**Amount of jumps the player has taken*/
  int jumps = 0;
  
  /**
  Creates a new player with a reference to the circle
  **/
  public Player(Circle c) {
    //Set ref to circle and calc player height
    circle = c;
    radius = c.radius / 10;
    //Slightly above the surface
    y = -c.radius * 1.5f;
    yMax = -c.radius + radius * .5f;
    //Init player
    init();
  }
  
  /**
  Reset to starting condition
  **/
  void init(){
    jumps = 0;
    yVel = 0;
    y = yMax;
    keyDown = false;
  }

  //Update applies a little bit of physics
  void update() {
    //Update the yMax, incase circle has changed
    yMax = -circle.radius - radius * .5f;
    //Increase y-velocity
    yVel += .3f;
    //Also apply friction to velocity
    yVel *= 0.95f;
    //Now add velocity to position
    y += yVel;
    //Check if we're not going through the ground
    if(y > yMax){
      y = yMax;
      //No bounce, since this screws with precision
      yVel = 0;
    }
  }
  
  /**
  Renders the player
  **/
  void render(){
    //Now draw the player
    ellipse(-radius * -.5f, y, radius, radius);
  }
  
  /**
  Makes the player jump
  **/
  boolean jump(){
    //Ignore if already falling or jumping, or key is still down
    if(yVel != 0 || y != yMax || keyDown) return false;
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
