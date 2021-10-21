import processing.video.*;

PImage img,img2;
float size = 1.0;
Capture webcam;

void setup() {
  img = loadImage("prinzipal.jpg");
  img2 = loadImage("Lenna.png");
  size(639, 959); 
  webcam = new Capture( this, width, height, 30 );
  webcam.start();
  smooth();
} 

void draw(){
  background(0, 0, 0);    // green
  pushMatrix();
  translate(width/2,height/2);
  pushMatrix();
  rotate(size/300.0);
  textSize(size);
  textAlign(CENTER,CENTER);
  text("ABCD",0,0);
  popMatrix();
  loadPixels();
  img.mask(pixels);
  popMatrix();
  image(webcam, 0, 0,width,height);
  image(img, 0, 0);
  
  size += 5.0;
}


void captureEvent( Capture webcam )
{
    webcam.read();
}

void keyPressed(){
  saveFrame("fr####.jpg");
}
