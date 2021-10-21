void setup() {
  size(640, 480, P3D);
}

float altezza = 100;
float altezza_2 = 150;

void draw() {
  background(255);
  lights();
  translate(width/2, height/2);
  rotateZ(radians(frameCount));
  rotateY(radians(frameCount));
  fill(255,0,0);
  beginShape(TRIANGLE_STRIP);
    for (int i=0; i<30; i++) {
      float x1 = cos( radians(i*10) ) * altezza;
      float y1 = sin( radians(i*10) ) * altezza;
      float x2 = cos( radians(i*10 + 5) ) * (altezza_2-i*4);
      float y2 = sin( radians(i*10 + 5) ) * (altezza_2-i*4);
      vertex(x1, y1, 0);
      vertex(x2, y2, 50+i);
    }
  endShape();
  
  pushMatrix();
  fill(255,255,0);
  translate(0,0,-100);
  rotateZ(radians(-frameCount));
  beginShape(QUAD_STRIP);
    for (int i=0; i<15; i++) {
      float x1 = cos( radians(i*10) ) * (altezza-i*5);
      float y1 = sin( radians(i*10) ) * (altezza-i*5);
      float x2 = cos( radians(i*10 + 5) ) * (altezza_2);
      float y2 = sin( radians(i*10 + 5) ) * (altezza_2);
      vertex(x1, y1, 0);
      vertex(x2, y2, 50+i);
    }
  endShape();
  popMatrix();
}
