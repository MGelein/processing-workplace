import processing.video.*;

Capture cam;
PImage hueOverlay;
PImage brightOverlay;
PImage satOverlay;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, width, height, cameras[0]);
    cam.start();     
  }
  
  
  
  satOverlay = createImage(width, height, ARGB);
  brightOverlay = createImage(width, height, ARGB);
  hueOverlay = createImage(width, height, ARGB);
}

void draw() {
  background(0);
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  
  loadPixels();
  hueOverlay.loadPixels();
  brightOverlay.loadPixels();
  satOverlay.loadPixels();
  for(int i = 0; i < pixels.length - 1; i++){
    float diff = abs(hue(pixels[i]) - hue(pixels[i + 1]));
    float c = map(diff, 5, 30, 255, 0);
    hueOverlay.pixels[i] = color(c, 0, 0, 255 - c);  
  }
  for(int i = 0; i < pixels.length - 1; i++){
    float diff = abs(brightness(pixels[i]) - brightness(pixels[i + 1]));
    float c = map(diff, 5, 30, 255, 0);
    brightOverlay.pixels[i] = color(0, 0, c, 255 - c);  
  }
  for(int i = 0; i < pixels.length - 1; i++){
    float diff = abs(saturation(pixels[i]) - saturation(pixels[i + 1]));
    float c = map(diff, 5, 30, 255, 0);
    satOverlay.pixels[i] = color(0, c, 0, 255 - c);  
  }
  for(int i = 0; i < pixels.length - 1; i++){
    pixels[i] = lerpColor(color(0), pixels[i], 0.5);
  }  
  
  background(255);
  
  
  updatePixels();
  hueOverlay.updatePixels();
  brightOverlay.updatePixels();
  satOverlay.updatePixels();
  
  //image(hueOverlay, 0, 0);
  //image(satOverlay, 0, 0);
  image(brightOverlay, 0, 0);
}
