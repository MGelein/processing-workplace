import processing.sound.*;

PVector gravity = new PVector(0, 0.2f);

ArrayList<Firework> fireworks = new ArrayList<Firework>();
PImage skyline;
SoundFile launchSound;
SoundFile[] bangs = new SoundFile[5];

float lightLevel = 0f;
int lightColor = color(0);
int ambientLight = color(100);

void setup(){
  size(800, 500);
  
  stroke(255);
  strokeWeight(2);
  colorMode(HSB);
  
  launchSound = new SoundFile(this, "launch.mp3");
  skyline = loadImage("skyline.jpg");
  bangs[0] = new SoundFile(this, "bang1.wav");
  bangs[1] = new SoundFile(this, "bang2.wav");
  bangs[2] = new SoundFile(this, "bang3.wav");
  bangs[3] = new SoundFile(this, "bang4.wav");
  bangs[4] = new SoundFile(this, "bang5.wav");
  
  createFirework();
}

void mousePressed(){
  createFirework();
}

void draw(){
  tint(lerpColor(ambientLight, lightColor, lightLevel), 50);
  lightLevel *= 0.5f;
  image(skyline, 0, 0);
  
  if(random(1) < .02) createFirework();
    
  
  for(int i = fireworks.size() - 1; i >= 0; i--){
    //Check if we want to live, if yes, show, else delete from list
    if(fireworks.get(i).update()){
      fireworks.get(i).show();
    }else{
      fireworks.remove(i);
    }
  }
}

void createFirework(){
  launchSound.play(random(0.8, 1.4));
  fireworks.add(new Firework());
}