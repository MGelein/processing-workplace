color white = color(255, 255, 255);
color black = color(0, 0, 0);
color green = color(0, 255, 0);

int[] surrounding = new int[8];

int w;
int h;
int scale = 4;
int firstIndex = 0;

PImage buffer;
PImage dBuffer;

void setup(){
  size(1280, 720, P2D);
  w = width / scale;
  h = height / scale;
  orientation(LANDSCAPE);
  
  dBuffer = createImage(w, h, RGB);
    
  //buffer = loadImage("gliderDestruction.png");//Four glider factories that will eventually be destroyed
  //buffer = loadImage("gliderFactory.png");//One glider factory
  //buffer = loadImage("glider.png");//One simple glider
  //buffer = loadImage("allWhite.png");//All white image
  
  buffer = createImage(w, h, RGB);
  int percentage = 50;
  
  background(0);
  buffer.loadPixels();
  int i = 0; int max = buffer.pixels.length;
  for(i = 0; i < max; i++){
     buffer.pixels[i] = (random(100) < percentage) ? white : black; 
  }
  buffer.updatePixels();
  
  //copy the contents to the double Buffer
  dBuffer.set(0, 0, buffer);
  frameRate(30);
}

void draw(){
  buffer.set(0, 0, dBuffer);
  buffer.loadPixels();
  dBuffer.loadPixels();  
  
  int i = 0; int max = buffer.pixels.length;
  int alive = 0; int j = 0;
  boolean firstFound = false;
  for(i = firstIndex; i < max; i++){
    alive = 0;
    
    if(!firstFound && buffer.pixels[i] == white){
      firstFound = true;
      firstIndex = max(0, i - w - 1);//Next time start counting from here
    }
    
    //create the new neighbors array
    surrounding[0] = i - w - 1;
    surrounding[1] = i - w;
    surrounding[2] = i - w + 1;
    surrounding[3] = i - 1;
    surrounding[4] = i + 1;
    surrounding[5] = i + w - 1;
    surrounding[6] = i + w;
    surrounding[7] = i + w + 1;
    
    for(j = 0; j < 8; j++){
      if(alive < 4){//If there is more than 4 alive, we know enough
        alive += (buffer.pixels[constrain(surrounding[j], 0, (w * h) - 1)] == white) ? 1 : 0;
      }
    }
    
    if(buffer.pixels[i] == white){
        if(alive < 2){ //Less than two neighbors, die of loneliness
           dBuffer.pixels[i] = black;
        }else if(alive > 3){ // More than 3 neighbors, die of overpopulation
           dBuffer.pixels[i] = black;
        }
    }else{
      if(alive == 3){ //If there are exactly 3 neighbours alive, then they create offspring
        dBuffer.pixels[i] = white;
      }
    }
  }
  
  dBuffer.updatePixels();
  image(dBuffer, 0, 0, width, height);
  
  fill(0);
  rect(0, 0, 100, 30);
  fill(255);
  textSize(16);
  text("Framerate: " + int(frameRate), 10, 20);
}