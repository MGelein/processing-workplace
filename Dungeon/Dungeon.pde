Game game;
TextureLoader textures;

void setup(){
  size(1280, 720, P3D);
  textureMode(NORMAL);
  colorMode(HSB);
  textures = new TextureLoader();
  game = new Game();
}

void draw(){
  background(0);
  cam.update();
  cam.render();
  
  sun.render();
  
  game.update();
  game.render();
}

void mousePressed(){
}

Sun sun = new   Sun();
class Sun{
  PVector dir = new PVector(0, 1, 0);
  
  void render(){
    directionalLight(20, 255, 100, dir.x, dir.y, dir.z);
    spotLight(0, 0, 255, cam.eye.x, cam.eye.y, cam.eye.z, cam.direction.x, cam.direction.y, cam.direction.z, PI / 2, 10);
  }
}

/**
Camera handling
**/
Camera cam = new Camera();
class Camera{
  
  PVector eye = new PVector(0, -200, 0);
  PVector target = new PVector(0, 0, 150);
  PVector up = new PVector(0, 1, 0);
  PVector direction;
  float speed = 5.0f;
  float viewDistance = 720;
  
  boolean isVisible(PVector pos){
    PVector dir = PVector.sub(eye, pos);
    dir.y = 0;
    if(PVector.sub(eye, pos).mag() > viewDistance) return false;
    dir.y = dir.z;
    if(PVector.angleBetween(new PVector(direction.x, direction.z), dir) < PI / 2) return false;
    return true;
  }
  
  
  void update(){
    if(keys.isDown(UP)){
      move(-speed, false, keys.isDown(SHIFT));
    }
    if(keys.isDown(DOWN)){
      move(speed, false, keys.isDown(SHIFT));
    }
    if(keys.isDown(LEFT)){
      move(speed, true, keys.isDown(SHIFT));
    }
    if(keys.isDown(RIGHT)){
      move(-speed, true, keys.isDown(SHIFT));
    }
    direction = PVector.sub(target, eye);
  }
  
  void move(float force, boolean sideways, boolean looking){
    PVector eyeXZ = new PVector(eye.x, eye.z, 0);
    PVector targetXZ = new PVector(target.x, target.z, 0);
    PVector dir = PVector.sub(eyeXZ, targetXZ);
    if(looking && sideways) force *= -.8f;
    dir.setMag(force);
    if(sideways) dir.rotate(PI / 2);
    dir.z = dir.y;
    dir.y = 0;
    eye.add(dir);
    if(!looking || !sideways) target.add(dir);
  }
  
  void render(){
    camera(eye.x, eye.y, eye.z, target.x, target.y, target.z, up.x, up.y, up.z);
  }
}

/**
KEY HANDLING
**/
Keys keys = new Keys();
class Keys{
  boolean[] keys = new boolean[256];
  
  void setState(int code, boolean state){
    keys[code] = state;
  }
  
  boolean isDown(int code){
    return keys[code] == true;
  }
  
  boolean isDownOnce(int code){
    if(keys[code] == true){
      keys[code] = false;
      return true;
    }
    return false;
  }
}

void keyPressed(){
  keys.setState(keyCode, true);
}

void keyReleased(){
  keys.setState(keyCode, false);
}