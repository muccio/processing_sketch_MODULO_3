/*PImage texture1;

void setup() {
  size(860, 480, P3D);
  texture1 = loadImage("stones2.jpg");
}

void draw() {
  background(255);
  lights();
  pushMatrix();
   translate(width/4,height/2);
   rotateY(radians(frameCount));
   textureMode(IMAGE);
   beginShape();
   texture(texture1);
   vertex(-100,-100,0,0);
   vertex(100,-100,640,0);
   vertex(100,100,640,640);
   vertex(-100,100,0,640);
   endShape(CLOSE);
   popMatrix();
   
   pushMatrix();
   textureMode(NORMAL);
   translate(width/2,height/2);
   rotateY(radians(-frameCount));
   beginShape();
   texture(texture1);
   vertex(-100,-100,0,0);
   vertex(100,-100,1,0);
   vertex(100,100,1,1);
   vertex(-100,100,0,1);
   endShape(CLOSE);
   popMatrix();
   
  
}
*/

int tubeRes = 32;
PImage img;

void setup() {
  size(400, 400, P3D);
  img = loadImage("stones.jpg");
  noStroke();
}
void draw() {
  background(0);
  translate(width/2, height/2);
  rotateX(map(mouseY, 0, height, -PI, PI));
  rotateY(map(mouseX, 0, width, -PI, PI));
  beginShape(QUAD_STRIP);
  texture(img);
  
  float angle = 270.0 / tubeRes;
  for (int i = 0; i < tubeRes; i++) {
    float x = cos(radians(i * angle)) * 100;
    float z = sin(radians(i * angle)) * 100;
    float u = img.width / tubeRes * i;
    vertex(x, -100, z, u, 0);
    vertex(x, 100, z, u, img.height);
  }
  endShape();
}
