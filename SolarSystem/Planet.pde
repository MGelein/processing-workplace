class Planet{
  
  float d;
  float r;
  float a;
  float t; //orbit speed
  int c;
  int l;
  Planet[] moons;
  PVector v;
  PShape globe;
    
  Planet(float dist, float radius, Planet parent){
    this.v = PVector.random3D();
    this.d = dist;
    this.r = radius;
    this.v.mult(this.d);
    this.a = random(TWO_PI);
    this.t = random(0.01, 0.05);
    this.t *= (random(0, 1) > 0.5) ? -1 : 1;
    if(parent == null) l = 0;
    else l = parent.l + 1;
    this.c = getColor();
    
    noStroke();
    fill(255);
    globe = createShape(SPHERE, this.r);
    globe.setTexture(texs[l]);
    
    spawnMoons();
  }
  
  private void spawnMoons(){
      int numMoons = int(random(0, 5 - (l)));
      if(this.l == 0) numMoons = 5;
      moons = new Planet[numMoons];
      for(int i = 0; i < moons.length; i++){
        float r = this.r * 0.6;
        float d = random(r + this.r * 1.05, r + this.r * 1.5);
        moons[i] = new Planet(d, r, this);
      }
  }
  
  void orbit(){
     a += t; 
     
     for(Planet p : moons){
        p.orbit(); 
     }
  }
  
  int getColor(){
     if(l == 0) return color(255, 255, 0); 
     if(l == 1) return (random(0, 1) < 0.5) ? color(0, 128, 0) : color(0, 0, 128);
     if(l == 2) return color(0, 255, 255);
     return 255;
  }
  
  
  void show(){
     pushMatrix();
     noStroke();
     fill(c);
     PVector axis = v.cross(new PVector(1, 0, 1));
     stroke(255);
     rotate(a, axis.x, axis.y, axis.z);
     line(0, 0, 0, v.x, v.y, v.z);
     
     translate(v.x, v.y, v.z);
     noStroke();
     shape(globe);
     //ellipse(0, 0, r, r);
     
     
     
     for(Planet p : moons){
        p.show();
     }
     
     popMatrix();
  }
}