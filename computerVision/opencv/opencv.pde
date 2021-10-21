import processing.video.*;
import gab.opencv.*;
import java.awt.*;


Capture video;
OpenCV opencv;

void setup(){
  size(640,480);
  video = new Capture(this,width,height);
  opencv = new OpenCV(this,width,height);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();
}

void draw(){
  opencv.loadImage(video);
  opencv.setROI(0,0,width,height);
  opencv.findCannyEdges(20,75);
  image(opencv.getOutput(),0,0);
  
  
  /*image(video,0,0);
  
  
  Rectangle[] volti = opencv.detect();
  println(volti.length);
  noFill();
  for(int i=0;i<volti.length;i++){ 
    stroke(0,255,0);
    strokeWeight(5);
    rect(volti[i].x,volti[i].y,volti[i].width,volti[i].height);
  }
  
  */
}

void captureEvent(Capture c){
  c.read();
}
