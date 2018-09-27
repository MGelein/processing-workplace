/**
The circle in the center of the endless runner  
**/
class Circle {
  //The radius of the circle
  float radius;
  //The speed the hurdles move at
  float speed = 0.01f;
  
  //List of all the hurdles
  ArrayList<Hurdle> hurdles = new ArrayList<Hurdle>();
  
  /**
   Creates the circle that is drawn
   **/
  public Circle() {
    this(50);
  }
  
  /**
  Creates a circle with the given radius
  **/
  public Circle(float r){
    radius = r;
  }

  /**
  Draws the circle
  */
  void render() {
    //First draw the hurdles at their given rotation
    for(Hurdle h : hurdles) h.render();
    //Draws the ellipse
    ellipse(0, 0, radius * 2, radius * 2);
  }
  
  /**
  Updates the circle
  **/
  void update(){
    //Update all the hurdles
    for(Hurdle h : hurdles) h.update(speed);
  }
  
  /**
  Adds one new hurdle to the circle
  **/
  void spawnHurdle(){
    hurdles.add(new Hurdle(radius));
  }
}

/**
One single hurdle across the surface of the circle
**/
class Hurdle{
  
  //Height of the hurlde
  float h = 10;
  //Width of the hurlde
  float w = 5;
  //Angle of the hurdle
  float a = PI;
  //y-position of the hurdle, probably identical to circle radsiu
  float y;
  // The height with the extra change from the sinus effect
  float sinHeight;
  
  /**
  Creates a new hurdle and its y position
  **/
  public Hurdle(float radius){
    y = radius;
    h = radius / 15;
  }
  
  //Renders this hurdle
  void render(){
    //Draw every rect at their given rotation, but first store camera matrix
    pushMatrix();
    //Modulate the height with the angle, this gives a nice effect
    sinHeight = h + abs(sin(a)) * h * 3; 
    //Now rotate the canvas
    rotate(a);
    //And draw the rectangle, 1 pix higher than visible to prevent clipping of lines
    rect(-w * 0.5f, -y - sinHeight * 0.5f - 1, w, sinHeight);
    //Restore the camera matrix
    popMatrix();
  }
  
  /** Does all the updating stuff for this hurlde (basically increase angle)*/
  void update(float speed){
    a -= speed;
  }
}
