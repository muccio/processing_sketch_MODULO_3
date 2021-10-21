/*
PImage texture1;
PImage texture2;

void setup()
{
    size( 640, 480, P3D );
    noStroke();
    
    texture1 = loadImage("stones.jpg");
    texture2 = loadImage("lines.jpg");
}

void draw()
{
    background( 255 );
    
    textureMode( IMAGE );
    pushMatrix();
    translate( width/4, height/2, 0 );
    rotateY( radians( frameCount ) );
    beginShape();
    texture( texture1 );
    vertex( -100, -100, 0, 0 );
    vertex(  100, -100, 640, 0 );
    vertex(  100,  100, 640, 640 );
    vertex( -100,  100, 0, 640 );
    endShape( CLOSE );
    popMatrix();

    textureMode( NORMAL );
    pushMatrix();
    translate( width*.75, height/2, 0 );
    rotateY( radians( -frameCount ) );
    beginShape();
    texture( texture2 );
    vertex( -100, -100, 0, 0 );
    vertex(  100, -100, 1, 0 );
    vertex(  100,  100, 1, 1 );
    vertex( -100,  100, 0, 1 );
    endShape( CLOSE );
    popMatrix();
}

*/
/*
int tubeRes = 32;
float[] tubeX = new float[tubeRes];
float[] tubeY = new float[tubeRes];
PImage img;
void setup() {
  size(400, 400, P3D);
  img = loadImage("stones.jpg");
  float angle = 270.0 / tubeRes;
  for (int i = 0; i < tubeRes; i++) {
    tubeX[i] = cos(radians(i * angle));
    tubeY[i] = sin(radians(i * angle));
  }
  noStroke();
}
void draw() {
  background(0);
  translate(width/2, height/2);
  rotateX(map(mouseY, 0, height, -PI, PI));
  rotateY(map(mouseX, 0, width, -PI, PI));
  beginShape(QUAD_STRIP);
  texture(img);
  for (int i = 0; i < tubeRes; i++) {
    float x = tubeX[i] * 100;
    float z = tubeY[i] * 100;
    float u = img.width / tubeRes * i;
    vertex(x, -100, z, u, 0);
    vertex(x, 100, z, u, img.height);
  }
  endShape();
  beginShape(QUADS);
  texture(img);
  vertex(0, -100, 0, 0, 0);
  vertex(100,-100, 0, 100, 0);
  vertex(100, 100, 0, 100, 100);
  vertex(0, 100, 0, 0, 100);
  endShape();
}
*/

// Vary the specular reflection component of a material
// with vertical position of the mouse
void setup() {
  size(400, 400, P3D);
  noStroke();
  colorMode(RGB, 1);
  fill(0.4);
}
void draw() {
  background(0);
  translate(width/2, height/2);
  // Set the specular color of lights that follow 
  lightSpecular(1, 1, 1);
  directionalLight(0.8, 0.8, 0.8, 0, 0, -1); 
  float s = mouseX / float(width);
  specular(s, s, s);
  sphere(100);
}
