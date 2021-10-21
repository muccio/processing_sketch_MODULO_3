/*
void setup() {
  size(400, 400, P3D);
  fill(204);
}
void draw() {
  lights();
  background(0);
  // Change height of the camera with mouseY 
  camera(30.0, mouseY, 220.0, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0,
         0.0, 1.0, 0.0);
  noStroke();
  box(90);
  stroke(255);
  line(-100, 0, 0, 100, 0, 0);
  line(0, -100, 0, 0, 100, 0);
  line(0, 0, -100, 0, 0, 100);
}
// centerX, centerY, centerZ
// upX, upY, upZ

*/
float x;
float z;

void setup()
{
    size( 640, 480, P3D );
    x = 0;
    z = 0;
    noStroke();
}

void draw()
{
    background( 255 );
    lights();
    x = cos( radians( frameCount ) ) * 1000;
    z = sin( radians( frameCount ) ) * 1000;
    camera( x, 0, z, width/2, height-50, -500, 1, 1, 0 );
    beginShape();
    fill( 255, 0, 0 );
    vertex( 0, height, 0);
    fill( 255, 255, 0 );
    vertex( 0, height, -1000 );
    fill( 0, 255, 0 );
    vertex( width, height, -1000 );
    fill( 0, 0, 255 );
    vertex( width, height, 0 );
    endShape(CLOSE);
    fill( 255 );
    pushMatrix();
    translate( width/2, height-50, -500 );
    box( 100 );
    popMatrix();
}
