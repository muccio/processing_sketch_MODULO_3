import processing.video.*;

int tubeRes = 32;
Capture webcam;

void setup() {
  size(800, 600, P3D);
  webcam = new Capture(this);
  webcam.start();
  noStroke();
}
void draw() {
  background(0);
  if(webcam.available()){
    webcam.read();
  }
  
  translate(width/2, height/2);
  rotateX(map(mouseY, 0, height, -PI, PI));
  rotateY(map(mouseX, 0, width, -PI, PI));
  
  beginShape(QUAD_STRIP);
  texture(webcam);
  float angle = 270.0 / tubeRes;
  for (int i = 0; i < tubeRes; i++) {
    float x = cos(radians(i * angle)) * 100;
    float z = sin(radians(i * angle)) * 100;
    float u = webcam.width / tubeRes * i;
    vertex(x, -100, z, u, 0);
    vertex(x, 100, z, u, webcam.height);
  }
  endShape();
  
}
