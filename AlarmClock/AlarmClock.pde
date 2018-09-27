import processing.sound.*;

String alarmTime = "08:00";
String alarmUrl = "https://www.youtube.com/watch?v=NlprozGcs80";

int alarmHours = 8;
int alarmMins  = 0;

void setup(){
  size(640, 360);
  frameRate(0.1);
  //fullScreen();
  background(0);
}

void draw(){
  //Normally a black background
  background(0);
  if(hour() == alarmHours && minute() == alarmMins){
    //White background, as a light
    background(255);
    alarm();
    frameRate(0.00001);
  }
}


void alarm(){
  link(alarmUrl);
}
