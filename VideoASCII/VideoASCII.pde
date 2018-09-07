import processing.video.*;

/**Character grayscale*/
String[] characters = {"$", "@", "B", "%", "8", "&", "W", "M", "#", "*", "o", "a", "h", "k", "b", "d", "p", "q", "w", "m", "Z", "O", "0", 
"Q", "L", "C", "J", "U", "Y", "X", "z", "c", "v", "u", "n", "x", "r", "j", "f", "t", "/", "\\", "|", "(", ")", "1", "{", "}", "[", "]", "?",
"-", "_", "+", "~", "<", ">", "i", "!", "l", "I", ";", ":", ",", "\"", "^", "`", "'", ".", " "};
/**The camera we're using*/
Capture cam;
/**Offscreen buffer we're rendering the webcam to*/
PGraphics buffer;
/**Pixels of characters*/
String[] converted;
/**Dynamic scale calculation*/
int scale = 10;
/**Sets contrastFactor*/
float contrastFactor = 1.0f;
/**Resolution of the character grey scale*/
int maxChar = characters.length;
/** If the cam feed is rendered */
boolean show_buffer = false;
/**If the effect is active*/
boolean show_glyphs = true;
/**target fps*/
int target_fps = 30;

/**
Entry point
**/
void setup() {
  //Setup stage and buffer
  size(1280, 960);
  frameRate(target_fps);
  buffer = createGraphics(128, 96);
  scale = width / buffer.width;
  
  
  //Create text display
  converted = new String[buffer.width * buffer.height];
  for(String s : converted) s = "";
  characters = reverse(characters);
  
  //Load external font
  textFont(createFont("Courier New Bold", scale * 1.2f));

  //Now create the webcam object
  cam = new Capture(this, buffer.width * 5, buffer.height * 5, 30);
  cam.start();
  
  //No stroke
  noStroke();
}

void keyPressed(){
  if(keyCode == DOWN && contrastFactor > 0.005){
    contrastFactor *= 0.9f;
  }else if(keyCode == UP && contrastFactor < 1000f){
    contrastFactor *= 1.1f;
  }else if(keyCode == LEFT && maxChar > 2){
    maxChar --;
  }else if(keyCode == RIGHT && maxChar < characters.length){
    maxChar ++;
  }
}

void keyReleased(){
  if(keyCode == 32) show_buffer = !show_buffer;
  if(keyCode == ENTER) show_glyphs = !show_glyphs;
}

void draw() {
  //Check if we can draw a frame, if so ,retrieve the new frame
  if (cam.available() == true) {
    cam.read();
  }else{
    //If no frame is ready, just leave the drawing as is
    return;
  }
  //Draw and filter the object to the buffer
  buffer.beginDraw();
  buffer.image(cam, 0, 0, buffer.width, buffer.height);
  buffer.filter(GRAY);
  buffer.endDraw();
  
  //Only show overlay if necessary
  if(show_buffer){
    image(buffer, 0, 0, (width - 358), height);
  }else{ //Or draw blue background
    fill(0, 0, 255);
    rect(0, 0, width - 349, height);
    fill(255);  
  }
  
  //Do we need to do the effect?
  if(show_glyphs){
    //Now go through all pixels of the buffer, and make them into characters
    float blue;
    String c;
    StringBuilder sb;
    int index;
    for(int y = 0; y < buffer.height; y ++){
      sb = new StringBuilder();
      for(int x = 0; x < buffer.width; x++){
        //Bit shift to grab blue channel
        blue = buffer.get(x, y) & 0xFF;
        //Multiply by contrast, ignore if contrast is zero
        blue += (blue - 125) * contrastFactor;
        if(blue > 255) blue = 255;
        else if(blue < 0) blue = 0;
        
        index = round(map(blue, 0, 255, 0, maxChar - 1));
        c = characters[round(map(index, 0, maxChar, 0, characters.length - 1))];
        sb.append(c);
      }
      //Don't print empty lines
      if(sb.toString().trim().length() > 1) text(sb.toString(), 0, (y + 1) * scale);
    }
  }
    
  //Draw the Interface and info text only once every other frame
  if(frameCount % 3 == 0){
    //Overwrite this region
    fill(0, 0, 255);
    rect(width - 350, 0, width, height);
    fill(255);
    //Now fill the gui controls
    float guiSize = 20;
    textSize(guiSize);
    text("CONTROLS", width - 350, scale * 3);
    text("=============================", width - 350, scale * 3 + guiSize);
    text("(u/d)   contrast:    " + ((contrastFactor < 0.005) ? "off" : contrastFactor), width - 350, scale * 3 + 2 * guiSize);
    text("(l/r)   char_res:    " + maxChar, width - 350, scale * 3 + 3 * guiSize);
    text("(space) show_buffer: " + (show_buffer ? "on" : "off"), width - 350, scale * 3 + 4 * guiSize);
    text("(enter) show_glyphs: " + (show_glyphs ? "on" : "off"), width - 350, scale * 3 + 5 * guiSize);
    text("INFO: ", width - 350, scale * 4 + 7 * guiSize);
    text("=============================", width - 350, scale * 4 + 8 * guiSize);
    text("framerate:  " + int(frameRate) + " fps", width - 350, scale * 4 + 9 * guiSize);
    text("camera_res: " + cam.width + "x" + cam.height + " @30fps", width - 350, scale * 4 + 10 * guiSize);
    text("buffer_res: " + buffer.width + "x" + buffer.height + " @" + target_fps + "fps", width - 350, scale * 4 + 11 * guiSize);
    text("window_res: " + width + "x" + height + " @" + target_fps + "fps", width - 350, scale * 4 + 12 * guiSize);
    textSize(scale * 1.2f);
  }
}
