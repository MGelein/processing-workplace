/**
 The circle in the center of the endless runner  
 **/
class Circle {
  //The radius of the circle
  float radius;
  //The speed the hurdles move at
  float speed = QUARTER_PI / (60 / 31);
  //In hurry mode the speed of the hurdles will slowly increase
  boolean hurryMode = false;

  /**
   Calculation of speed:
   playMusic is 124BPM, thus 1 beat is about 0,48 seconds
   I want 4 beats every quarter circle, thus every halfcircle should take 1,935s.
   HALF_PI / (60 / 31) = radians per second
   **/

  //List of all the hurdles
  ArrayList<Hurdle> hurdles = new ArrayList<Hurdle>();

  //The wave effect controller
  Wave wave;

  /**
   Creates the circle that is drawn
   **/
  public Circle() {
    this(50);
  }

  /**
   Creates a circle with the given radius
   **/
  public Circle(float r) {
    radius = r;
    wave = new Wave();
  }

  /**
   Draws the circle
   */
  void render() {
    //First draw the hurdles at their given rotation
    for (Hurdle h : hurdles) h.render();
    //Draws the ellipse
    fill(0);
    stroke(gameColor);
    strokeWeight(gameWeight);
    ellipse(0, 0, radius * 2, radius * 2);
    noFill();

    //Now draw the rotate lines. these create the effect that the hurdles get blown out
    strokeWeight(1);
    float spread = radians(player.getSpread());
    pushMatrix();
    rotate(-spread / 2);
    line(0, 0, 0, -radius);
    rotate(spread);
    line(0, 0, 0, -radius);
    popMatrix();

    //And finally draw any waves
    wave.render();
  }

  /**
   Restarts the game
   **/
  void init() {
    //Empty list
    hurdles.clear();
    wave.clear();
    hurryMode = false;
  }

  /**
   Checks the collision with the player and all appropriate hurdles
   **/
  boolean collision(Player p) {
    //Check all hurdles, ignore ones not even close
    for (Hurdle h : hurdles) {
      float spread = p.getSpread() * .5f;
      //Test to see if it is in range
      if (h.getRot() > 180 - spread && h.getRot() < 180 + spread) {
        if (h.getHeight() > abs(p.y + p.radius)) {
          return true;
        }
      }
    }
    return false;
  }

  /**
   Updates the circle
   Gets passed fraction of a second
   **/
  void update(float delta) {
    //Update all the hurdles
    for (Hurdle h : hurdles) h.update(speed * delta);

    //If there are hurdles, we are keeping score
    if (hurdles.size() > 0) player.score+= hurdles.size();

    //Update the wave
    wave.update();

    //Update hurryMode, this takes roughly two minutes to reach double velocity!
    if (hurryMode) speed += 0.0001f;
  }
  /**
   Adds one new hurdle to the circle
   **/
  void spawnHurdle() {
    //If this is the first hurdle, start playing game music
    if (hurdles.size() == 0) {
      sound.startPlay();
    }
    hurdles.add(new Hurdle(radius, radians(player.getSpread())));
    if (hurdles.size() == 1) {
      wave.wave(20);
    } else {
      wave.wave();
    }
    //Set the alpha of new draw calls to 0, this will ease to the new value
    actualAlpha = 0;
    //Now also add remarks based on how far we are
    if (hurdles.size() % 10 == 0) {//Every 10 hurdles, add a remark
      //On hurdle 50, increase spead, else pick a random remark!
      if (hurdles.size() == 50) {
        ui.addRemark("FASTER!");
        hurryMode = true;
      } else {
        ui.randomRemark();
      }
    }
    yShake = 10;
  }
}

/**
 One single hurdle across the surface of the circle
 **/
class Hurdle {

  //Height of the hurlde
  float h = 10;
  //Width of the hurlde
  float w = 5;
  //Angle of the hurdle
  float a = PI;
  //y-position of the hurdle, probably identical to circle radius
  float y;
  // The height with the extra change from the sinus effect
  float sinHeight;
  // The width wit the extra change from the sinus effect
  float sinWidth;
  // If this rect is in danger of being squashed
  boolean inDanger = false;

  /**
   Creates a new hurdle and its y position
   **/
  public Hurdle(float radius, float startAngle) {
    y = 0;
    h = radius / 15;
    a = -startAngle + PI;
  }

  /**Returns the angle of the circle this is on*/
  float getRot() {
    return abs(degrees((a - PI) % TWO_PI));
  }

  /** Returns the height the ball should be above*/
  float getHeight() {
    return y + h;
  }

  //Renders this hurdle
  void render() {
    //Draw every rect at their given rotation, but first store camera matrix
    pushMatrix();
    //Modulate the height with the angle, this gives a nice effect
    sinHeight = h + abs(sin(a)) * h * 4;
    sinWidth = w + abs(sin(a)) * w;
    //For the first quarter turn, ease their y to full circle radius
    y += (h * 15 - y) * 0.1;    
    //Now rotate the canvas
    rotate(a);
    //And draw the rectangle
    noStroke();
    fill(inDanger ? 255 : gameColor);
    rect(0, -y - sinHeight * 0.5f, sinWidth, sinHeight);
    stroke(gameColor);
    strokeWeight(1);
    line(0, -circle.radius, 0, -1000);
    //Restore the camera matrix
    popMatrix();

    //Reset inDanger variable
    if (inDanger) inDanger = false;
  }

  /** Does all the updating stuff for this hurlde (basically increase angle)*/
  void update(float speed) {
    a -= speed;
  }
}
