class Ball{
  float x;
  float y;
  float vx;
  float vy;
  boolean started = false;
  float r = 10;
  
  Ball(){
    x = width / 2;
    y = (height / 4) * 3;
    vx = vy = 0;
  }
  
  void start(){
    if(random(1) > 0.5){
      vx = -5;
      vy = -5;
    }else{
      vx = 5;
      vy = 5;
    }
    started = true;
  }
  
  void update(){
    
    if(!started){
      x = paddle.x;
      y = paddle.y - paddle.h / 2 - r;
      return; 
    }
    
    x += vx;
    y += vy;
    
    if(x > width - r){
      x = width - r;
      if(vx > 0) vx *= -1;
    }else if(x < r){
      x = r;
      if(vx < 0) vx *= -1;
    }
    
    if(y > height - r){
      //Bottom line
      started = false;
    }else if(y < r){
      y = r;
      if(vy < 0) vy *= -1;
    }
  }
  
  void render(){
    ellipse(x, y, r * 2, r * 2);
    
    stroke(0, 255, 0);
  }
}
