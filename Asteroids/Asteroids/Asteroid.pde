class Asteroid{
  PVector pos = new PVector(random(width), random(height));
  float r = random(15, 50);
  float heading = 0;
  float rotation = random(-0.03, 0.03);
  int total = floor(random(5, 15));
  float[] offset = new float[total];
  PVector vel = PVector.random2D();
  boolean dead = false;
  
  public Asteroid(){
    calcOffset();
  }
  
  void calcOffset(){
    for(int i = 0; i < offset.length; i++) offset[i] = random(-(r/3), (r/3));
  }
  
  public Asteroid(PVector position, float radius){
    r = radius;
    pos = position.copy();
    calcOffset();
  }
  
  ArrayList<Asteroid> breakUp(){
    ArrayList<Asteroid> list = new ArrayList<Asteroid>();
    dead = true;
    if(r < 15) return list;
    list.add(new Asteroid(pos, r * 0.7));
    list.add(new Asteroid(pos, r * 0.7));
    return list;
  }
  
  void edges(){
    if(pos.x > width + r){
      pos.x = -r;
    }else if(pos.x < -r){
      pos.x = width + r;
    }
    if(pos.y > height + r){
      pos.y = -r;
    }else if(pos.y < -r){
      pos.y = height + r;
    }
  }
  
  void render(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(heading);
    beginShape();
    for(int i = 0; i < total; i++){
      float angle = map(i, 0, total, 0, TWO_PI);
      float cR = r + offset[i];
      float x = cR * cos(angle);
      float y = cR * sin(angle);
      vertex(x, y);
    }
    endShape(CLOSE);
    popMatrix();
    
    edges();
    heading += rotation;
    
    pos.add(vel);
  }
}
