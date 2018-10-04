class Brick{
  float x = 0;
  float y = 0;
  float w = 120;
  float h = 20;
  boolean dead = false;
  boolean checking = false;
  
  Brick(float xPos, float yPos){
    x = xPos;
    y = yPos;
  }
  
  void update(){
    if(dead) return;
    checking = false;
    if(ball.x < x + (w / 2) && ball.x > x - (w / 2)){
      float distY = abs(y - ball.y);
      if(distY < (h / 2) + ball.r){
        if(y < ball.y){
          ball.y = y + ball.r + h / 2;
          if(ball.vy < 0) ball.vy *= -1;
        }else{
          ball.y = y - ball.r - h / 2;
          if(ball.vy > 0) ball.vy *= -1;
        }
        dead = true;
      }
    }
    if(ball.y < y + (h / 2) && ball.y > y - (h / 2)){
      float distX = abs(x - ball.x);
      if(distX < (w / 2) + ball.r){
        if(x < ball.x){
          ball.x = x + ball.r + w / 2;
          if(ball.vx < 0) ball.vx *= -1;
        }else{
          ball.x = x - ball.r - w / 2;
          if(ball.vx > 0) ball.vx *= -1;
        }
        dead = true;
      }
    }
  }
  
  void render(){
    if(dead){
      stroke(255);
      noFill();
    }
    else{
      noStroke();
      fill(255);
    } 
    
    if(checking){
      stroke(255, 0 ,0);
    }
    rect(x, y, w, h);
  }
}
