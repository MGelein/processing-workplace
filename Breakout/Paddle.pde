class Paddle{
  float x;
  float y;
  float w = 200;
  float h = 10;
  
  Paddle(){
    x = width / 2;
    y = height - 30;
  }
  
  void update(){
    float dx = (mouseX - x);
    x = x + dx * 0.05f;
    
    if(x > width - w / 2){
      x = width - w / 2;
    }else if(x < w / 2){
      x = w / 2;
    }
    
    if(ball.x < x + w / 2 && ball.x > x - w / 2){
      float distY = abs(y - ball.y);
      if(distY < h / 2 + ball.r){
        if(y < ball.y){
          ball.y = y + ball.r + h / 2;
        }else{
          ball.y = y - ball.r - h / 2;
        }
        ball.vy *= -1;
      }
    }
    if(ball.y < y + h / 2 && ball.y > y - h / 2){
      float distX = abs(x - ball.x);
      if(distX < w / 2 + ball.r){
        if(x < ball.x){
          ball.x = x + ball.x + w / 2;
        }else{
          ball.x = x - ball.r - w / 2;
        }
      }
      ball.vx *= -1;
    }
  }
  
  void render(){
    rect(x, y, w, h);
  }
}
