/**
 This class takes care of the wave effect, this congtrols all ripples
 **/
class Wave {
  //List of all ripples
  ArrayList<Ripple> ripples = new ArrayList<Ripple>();
  //List of ripples that need to be removed
  ArrayList<Ripple> toRemove = new ArrayList<Ripple>();

  //Update all ripples, and check if they need to be removed
  void update() {
    for (Ripple r : ripples) {
      if (!r.update()) toRemove.add(r);
    }
    //Check if we need to remove any
    if (toRemove.size() > 0) {
      for (Ripple r : toRemove) ripples.remove(r);
      toRemove.clear();
    }
  }

  //Add a new ripple with predefined strength
  void wave(float str) {
    while (str > 3) {
      ripples.add(new Ripple(str, true));
      str --;
    }
  }

  //Adds a new ripple
  void wave() {
    ripples.add(new Ripple());
  }

  void clear() {
    ripples.clear();
    toRemove.clear();
  }

  /**
   Renders the ripples
   **/
  void render() {
    for (Ripple r : ripples) r.render();
  }
}

/**
 This class holds a single ripple
 **/
class Ripple {
  //The size of a ripple starts at 0
  float size = 0;
  float speed = 0;
  boolean noGrav = false;

  public Ripple() {
    this(5);
  }

  public Ripple(float str, boolean noGravity) {
    speed = str;
    size = circle.radius * 2;
    noGrav = noGravity;
  }

  public Ripple(float str) {
    this(str, false);
  }

  //Over time the size of the ripple decreases
  boolean update() {
    //change the size over time
    size += speed;
    //Decrease the size change over time
    if (noGrav) {
      //Withouth gravity, just rmove the circles once they are too big
      if (size > width * 3) return false;
    } else {
      speed -= 0.2;
    }

    if (size < 1) return false;
    return true;
  }

  //Draw this circle, and 
  void render() {
    //Decrease alpha as you're decreasing size
    float alpha = (size / circle.radius) * 255;
    stroke(gameColor, alpha);
    strokeWeight(1);
    ellipse(0, 0, size, size);
  }
}


//Registers the score online
void registerScore(){
  loadStrings("https://www.interwing.nl/runner/score.php?s=" + player.score + "&u=" + getUserName().trim() + "&t=" + millis());
}
