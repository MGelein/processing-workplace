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
  
  if(i < sorted.pixels.length){
    int times = 0;
    while(times < 10){
      times++;
      float record = -1;
        int selectedPixel = i;
        for(int j = i; j < sorted.pixels.length; j++){
          color pix = sorted.pixels[j];
          float b = saturation(pix);
          if(b > record){
            selectedPixel = j;
            record = b;
          }
        }
        //Swap the selected with i
        color temp = sorted.pixels[selectedPixel];
        sorted.pixels[selectedPixel] = sorted.pixels[i];
        sorted.pixels[i] = temp;
      sorted.updatePixels();
      i++;
    }
  }
  
  background(0);
  image(img, 0, 0);
  image(sorted, img.width, 0);
}
