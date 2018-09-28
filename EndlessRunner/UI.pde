/**
Holds all the (VERY DIRTY) ui code.
**/
class UI{
  
  float textHeight;
  float scoreX = 0;
  float scoreX2 = 0;
  float sizeBonus = 0.2f;
  int previousMult = 0;
  /**
  Creates and initializes the ui object
  **/
  public UI(){
    //Calculate font size
    textHeight = width / 15;
    textSize(textHeight);
    //Load the font
    textFont(createFont("digital.ttf", textHeight));
  }
  
  /**Draws the score Text*/
  void renderScore(){
    //Draw score text
    textSize(textHeight);
    String scoreText = "Score: " + player.score;
    scoreX += ((textWidth(scoreText) * -.5f) - scoreX) * .1f;
    text(scoreText, scoreX, textHeight);
    //Now draw multiplier
    if(player.jumps != previousMult){//If we have a change in multiplier, please add a little textsize
      sizeBonus = 0.2f;
      previousMult = player.jumps;
    }
    textSize(textHeight * .7f + sizeBonus * textHeight);
    String multScore = "Multiplier: x" + player.jumps;
    scoreX2 += ((textWidth(multScore) * -.5f) - scoreX2) * .1f;
    text(multScore, scoreX2, textHeight + textHeight * .7f);
    sizeBonus *= 0.9f;//Decrease fast
  }
  
  /**Draws the play cue*/
  void renderCue(){
    //Draw cue text
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
  }
}
