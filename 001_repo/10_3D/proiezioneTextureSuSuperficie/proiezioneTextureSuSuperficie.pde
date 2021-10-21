import codeanticode.syphon.*;

import processing.video.*;

int cols, rows;
int scl = 20;
int w = 2000;
int h = 1600;
 
float flying = 0;
 
float[][] terrain;


Capture cam;
PGraphics pg;
PImage texture1;

PImage img;
SyphonServer server;
 
void setup() {
  size(600, 600, P3D);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
  String http = "http://";
  img = loadImage( http + "www.tfguy44.com/MyIcon1.PNG");
  //texture(img);
  
  String[] cameras = Capture.list();
  
    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println(i+" "+cameras[i]);
      }
    }
    cam = new Capture(this, cameras[0]);
    cam.start();  
     
    server = new SyphonServer(this, "Processing Syphon");
}
 
 
void draw() {
 
  flying -= 0.1;
 
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    yoff += 0.2;
  }
 
  background(0);
  translate(width/2, height/2+50);
  rotateX(PI/3);
  scale(0.5);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    texture(cam);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y], map(x,0,cols,0,cam.width), map(y,0,rows,0,cam.height) );
      vertex(x*scl, (y+1)*scl, terrain[x][y+1], map(x,0,cols,0,cam.width), map(y+1,0,rows,0,cam.height));
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
  server.sendScreen();
}


void captureEvent(Capture c) {
  c.read();
}
