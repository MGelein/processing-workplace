import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

Planet sun;

PeasyCam cam;

PImage[] texs = new PImage[5];

void setup(){
  size(600, 600, P3D);
  texs[0] = loadImage("sunmap.jpg");
  texs[1] = loadImage("earthmap.jpg");
  texs[2] = loadImage("neptunemap.jpg");
  texs[3] = loadImage("jupitermap.jpg");
  texs[4] = loadImage("venusmap.jpg");
  cam = new PeasyCam(this, 500);
  sun = new Planet(0, 70, null);
}

void draw(){
  background(0);
  lights();
  
  sun.show();
  sun.orbit();
}