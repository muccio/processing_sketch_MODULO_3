import processing.video.*;
 
Movie myMovie;
Capture cam;

PShape superficie;

void setup() {
  size(800, 600, P3D);
 
  myMovie = new Movie(this, "launch2.mp4");
  myMovie.loop();
  
  cam = new Capture(this, 640,480);
  cam.start();
}
 
 
void draw() {
  background(0);
  pushMatrix();
  translate( width/2, 0, 0 );
  rotateY( radians( frameCount ) );
  beginShape();
  texture(cam);
  vertex( 0, 0, 0, 0 );
  vertex(  560, 0, 560, 0 );
  vertex(  560,  406, 560, 406 );
  vertex( 0,  406, 0, 406 );
  endShape();
  popMatrix();
}
 
void keyPressed() {
  exit();
}

void captureEvent(Capture c) {
  c.read();
}
 
void movieEvent(Movie m) {
  if (myMovie.available()) m.read();
}
