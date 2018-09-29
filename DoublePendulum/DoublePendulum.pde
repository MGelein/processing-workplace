//Size of the arms
float r1 = 200;
float r2 = 200;
//Mass of the balls
float m1 = 40;
float m2 = 40;
//The angles of the arms
float a1 = HALF_PI;
float a2 = HALF_PI;
//The velocity of the angles
float a1_v = 0;
float a2_v = 0;
//The acceleration of the angles
float a1_a = 0;
float a2_a = 0;
//The universal gravitational constant
float g = 1;
//The canvas to trace on
PGraphics canvas;
//The previous positions of the tip
float px2 = -1;
float py2 = -1;

//Entry point
void setup() {
  //Size of window
  size(900, 600);
  //Create a new canvas
  canvas = createGraphics(width, height);
  //Only draw background once, so now the trace no longer gets removed
  canvas.beginDraw();
  canvas.background(0);
  //colorMode HSB
  canvas.colorMode(HSB);
  canvas.endDraw();
}

//Draw every frame
void draw() {
  //Calculate the angular acceleration of angle 1
  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1 - 2 * a2);
  float num3 = -2 * sin(a1 - a2) * m2;
  float num4 = a2_v * a2_v * r2 + a1_v * a1_v * r1 * cos(a1 - a2);
  float den = r1 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
  a1_a = (num1 + num2 + num3 * num4) / den;

  //Calculate the angular acceleration of angle 2
  num1 = 2 * sin(a1 - a2);
  num2 = (a1_v * a1_v * r1 * (m1 + m2));
  num3 = g * (m1 + m2) * cos(a1);
  num4 = a2_v * a2_v * r2 * m2 * cos(a1 - a2);
  den = r2 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
  a2_a = (num1 * (num2 + num3 + num4)) / den;

  //Draw canvas as background black fill
  image(canvas, 0, 0);
  fill(255);
  //Black stroke
  strokeWeight(2);
  stroke(255);
  //Now translate screen, only a little down
  translate(width / 2, 120);

  //Now calculate x1, y1
  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);
  //Now draw the line and ball at that point
  line(0, 0, x1, y1);
  ellipse(x1, y1, m1, m1);

  //Next calculate x2, y2 (offset by x1,y1);
  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);
  //Then draw the line and ball at that point
  line(x1, y1, x2, y2);
  ellipse(x2, y2, m2, m2);

  //Update the velocities
  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;

  //Draw the trace onto the canvas
  canvas.beginDraw();
  canvas.strokeWeight(1);
  canvas.stroke(frameCount % 255, 255, 255);
  canvas.translate(width / 2, 120);
  if (frameCount > 1) canvas.line(px2, py2, x2, y2);
  canvas.endDraw();

  px2 = x2;
  py2 = y2;
}
