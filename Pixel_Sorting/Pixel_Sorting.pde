PImage img;
PImage sorted;
int i = 0;

void setup(){
  size(800, 400);
  img = loadImage("image.jpg");
  sorted = createImage(img.width, img.height, RGB);
  sorted.loadPixels();
  sorted = img.get();
  
  sorted.updatePixels();
  
  frameRate(60);
}

void draw(){
  sorted.loadPixels();
  color temp;
  if(i < sorted.pixels.length){
    int times = 0;
    while(times < 5){
      times++;
      for(int j = 0; j < sorted.pixels.length - 1; j++){
          if(hue(sorted.pixels[j]) < hue(sorted.pixels[j + 1])){
            temp = sorted.pixels[j];
            sorted.pixels[j] = sorted.pixels[j + 1];
            sorted.pixels[j + 1] = temp;
          }
      }
      i++;
    }
    sorted.updatePixels();
  }
  
  background(0);
  image(img, 0, 0);
  image(sorted, img.width, 0);
}
