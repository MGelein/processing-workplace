/**
 Holds all the (VERY DIRTY) ui code.
 **/
class UI {

  //List of remarks
  ArrayList<Remark> remarks = new ArrayList<Remark>();
  //Remarks ready for deletion
  ArrayList<Remark> toRemove = new ArrayList<Remark>();
  float textHeight;
  float scoreX = 0;
  float scoreX2 = 0;
  float sizeBonus = 0.2f;
  int previousMult = 0;

  /**
   Creates and initializes the ui object
   **/
  public UI() {
    //Calculate font size
    textHeight = height / 15;
    textSize(textHeight);
    //Load the font
    textFont(createFont("digital.ttf", textHeight));
  }

  /**Draws the score Text*/
  void renderScore() {
    fill(gameColor);
    //Draw score text
    textSize(textHeight);
    String scoreText = "Score: " + player.score;
    //Overwrite player score, if it is zero to give cue to start
    if (player.score == 0) scoreText = "UP, SPACE or MOUSE";
    scoreX += ((textWidth(scoreText) * -.5f) - scoreX) * .1f;
    text(scoreText, scoreX, textHeight);
    //Now draw multiplier
    if (player.jumps != previousMult) {//If we have a change in multiplier, please add a little textsize
      sizeBonus = 0.2f;
      previousMult = player.jumps;
    }
    textSize(textHeight * .7f + sizeBonus * textHeight);
    String multScore = "Multiplier: x" + player.jumps;
    if (player.score == 0) multScore = "to start playing!";
    scoreX2 += ((textWidth(multScore) * -.5f) - scoreX2) * .1f;
    text(multScore, scoreX2, textHeight + textHeight * .7f);
    sizeBonus *= 0.9f;//Decrease fast

    //Now update the remarks
    updateRemarks();
  }

  //Adds a new remark
  void addRemark(String s) {
    remarks.add(new Remark(s));
  }

  //Random exclamation
  void randomRemark() {
    //Random exclamations, pick one
    String[] exclamations = new String[]{"NICE!", "GOOD JOB!", "KEEP GOING!", "GO ON!", "SMOOTH!", "WOW!"};
    //Now pick a random one and add it
    addRemark(exclamations[int(random(exclamations.length))]);
  }

  //Handles the rednering and updating of the remarks
  void updateRemarks() {
    for (Remark r : remarks) {
      if (!r.render()) {
        toRemove.add(r);
      }
    }
    //Now see if we have to remove any remarks
    if (toRemove.size() > 0) {
      for (Remark r : toRemove) remarks.remove(r);
      toRemove.clear();
    }
  }

  /**Draws the play cue*/
  void renderCue() {
    //Draw cue text
    fill(gameColor);
    textSize(textHeight);
    String text = "Tap to start!";
    scoreX += ((textWidth(text) * -.5f) - scoreX) * .1f;
    text(text, scoreX, textHeight);
    //Now draw previous score
    textSize(textHeight * .7f);
    String previousScore = "Previous score: " + player.score;
    scoreX2 += ((textWidth(previousScore) * -.5f) - scoreX2) * .1f;
    text(previousScore, scoreX2, textHeight + textHeight * .7f);
    previousMult = player.jumps;
    //Also update the remarks
    updateRemarks();
  }
}

/**
 Make remarks to start with
 **/
class Remark {

  //The text of the remark
  String text;
  //Size of the letters
  float size;
  //Amount of speed on growing size letters
  float sizeAcc;

  //Create a new remark
  public Remark(String s) {
    text = s;
    size = ui.textHeight;
    sizeAcc = size * .2f;
  }

  //Renders and updates the string
  boolean render() {
    //Do the render
    textSize(size);
    float tw = textWidth(text);
    text(text, -tw * .5f, -size * .5f);

    //Do all the physicsy stuff
    size += sizeAcc;
    //Decrease the acceleration
    sizeAcc -= 0.5f;
    //If the size < 1, no longer render
    if (size < 1) return false;
    //Else we are cool to render
    return true;
  }
}
