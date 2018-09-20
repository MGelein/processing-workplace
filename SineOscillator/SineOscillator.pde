import processing.sound.*;

//Create the Sine Oscillator.
SinOsc osc;

//The textsize
int textSize = 16;

void setup(){
  //Create the size of the app
  size(640, 360);
  textSize(textSize);
  
  //Create the oscillator using this applet as parent
  osc = new SinOsc(this);
  //Set frequency and amplitude to 0 to start
  osc.freq(0);
  osc.amp(0);
  osc.play();
}

void draw(){
  //Reset BG
  background(0);
  
  //Every frame, set volume of the oscilator according to the x-position
  float amp = map(mouseY, height, 0, 0, 1);
  osc.amp(amp);
  //Every frame, set the frequency o the oscillator relative to y-position
  float freq = map(mouseX, 0, width, 0, 5000);
  osc.freq(freq);
  
  //Draw the two lines that show where the mouse is
  stroke(255);
  line(0, mouseY, width, mouseY);
  line(mouseX, 0, mouseX, height);
  String text = "Amp: " + (int(amp * 100) / 100f) + " Freq: " + int(freq) + "hz";
  float textW = textWidth(text);
  float textY = mouseY + ((mouseY > height - textSize) ? 0: textSize);
  float textX = mouseX + ((mouseX > width - textW) ? - textW: 0);
  text(text, textX, textY);
  
}
