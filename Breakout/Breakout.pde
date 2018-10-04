Paddle paddle;
Ball ball;
ArrayList<Brick> bricks = new ArrayList<Brick>();

void setup(){
  size(1280, 720);
  rectMode(CENTER);
  
  paddle = new Paddle();
  ball = new Ball();
  
  makeGrid();
}

void draw(){
  background(0);
  fill(255);
  noStroke();
  
  paddle.update();
  paddle.render();
  
  ball.update();
  ball.render();
  
  int count = 0;
  for(Brick b: bricks) {
    b.update(); 
    b.render();
    if(b.dead) count ++;
  }
  
  if(count == bricks.size()){
    ball.started = false;
    println("You won!");
  }
}

void makeGrid(){
  for(int x = 0; x < 10; x++){
    for(int y = 0; y < 10; y++){
      Brick b = new Brick(x * 128 + 64, y * 30 + 15);
      bricks.add(b);
    }
  }
}

void mousePressed(){
  ball.start();
}
