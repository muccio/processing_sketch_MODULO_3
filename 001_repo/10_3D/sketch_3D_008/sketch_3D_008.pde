/*
import processing.dxf.*;
boolean record = false;
void setup() {
  size(400, 400, P3D);
  noStroke();
  sphereDetail(12);
}
void draw() {
  if (record == true) {
    beginRaw(DXF, "output.dxf");
  // Start recording to the file
  }
  lights();
  background(0);
  translate(width/3, height/3, -200);
  rotateZ(map(mouseY, 0, height, 0, PI));
  rotateY(map(mouseX, 0, width, 0, HALF_PI));
  for (int y = -2; y < 2; y++) {
    for (int x = -2; x < 2; x++) {
      for (int z = -2; z < 2; z++) {
        pushMatrix();
        translate(120*x, 120*y, -120*z);
        sphere(30);
        popMatrix();
      } 
    }
  }
  if (record == true) {
    endRaw();
    record = false;
    // Stop recording to the file
  }
}

void keyPressed() {
  // Press R to save the file
  if (key == 'R' || key == 'r') {
    record = true;
  } 
}
*/
/*
import nervoussystem.obj.*;

boolean record;

void setup() {
  size(400,400,P3D);
  smooth();
}

void draw() {
  background(0);
  
  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "filename.obj");
  }
  
  fill(255);
  box(100,100,100);
  translate(width/2, height/2);
  box(100,100,100);
  
  if (record) {
    endRecord();
    record = false;
  }
}

void keyPressed()
{
  if (key == 'r') {
    record = true;
  }
}
*/

PShape s;

void setup() {
  size(600, 600, P3D);
  // The file "bot.obj" must be in the data folder
  // of the current sketch to load successfully
  s = loadShape("pencil.obj");
}

float ang = 0.0;
void draw() {
  background(0);
  lights();
  directionalLight( 255, 255, 255, 0, 1, 0 );
  translate(width/2, height/2);
  rotateZ (ang);
  rotateY (ang);
  rotateX (ang);
  scale(200);
  shape(s, 0, 0);
  ang+=PI/128;
}
