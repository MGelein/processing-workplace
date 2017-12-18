class Sprite{
  float w;
  float h;
  float h2;
  float w2;
  
  Sprite(PImage img){
    setHeight(img.height);
    setWidth(img.width);
  }
  
  void setHeight(float hght){
    h = hght;
    h2 = h / 2;
  }
  
  void setWidth(float wdth){
    w = wdth;
    w2 = w / 2;
  }
}