class Ship extends Sprite{
  
  PVector vel;
  PVector acc;
  PVector pos;
  PVector nosePos;
  PVector noseOffset;
  float friction = 0.9f;
  float force = 1.0f;
  int cooldown = 0;
  int fireRate = 15;
  
  Ship(){
    super(imageLoader.ship);
    pos = new PVector(10.0f, height / 2);
    noseOffset = new PVector(imageLoader.ship.width, imageLoader.ship.height / 2 + 3);
    vel = new PVector();
    acc = new PVector();
  }
  
  void update(){
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
    
    vel.mult(friction);
    
    handleInput();
    
    cooldown --;
  }
  
  private void handleInput(){
    if(keyListener.isDown(37)){//LEFT
      acc.x = -force;
    }
    if(keyListener.isDown(39)){//RIGHT
      acc.x = force;
    }
    if(keyListener.isDown(38)){//TOP
      acc.y = -force;
    }
    if(keyListener.isDown(40)){//DOWN
      acc.y = force;
    }
    
    if(keyListener.isDown(32)){//SPACE
      shoot();
    }
  }
  
  void shoot(){
    if(cooldown < 0){
      cooldown = fireRate;
      nosePos = PVector.add(pos, noseOffset);
      game.bullets.addBullet(new Bullet(nosePos.x, nosePos.y));
    }
  }
  
  void show(){
    image(imageLoader.ship, pos.x, pos.y);
  }
}