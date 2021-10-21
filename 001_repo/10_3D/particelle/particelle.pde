import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import peasy.PeasyCam;

PeasyCam cam;
int npartTotal = 5000;
float partSize = 1;
PVector positions[];
int fcount, lastm;
float frate;
int fint = 3;
PostFX fx;

void setup() {
  size(800, 600, P3D);
  frameRate(60);
  cam = new PeasyCam(this, 400);
  initPositions();
  fx = new PostFX(this);
} 

void draw () {
  background(0);
  lights();
  for (int n = 0; n < npartTotal; n++) {
    drawParticle(positions[n]);
    moveParticle(n);
  }
  fcount += 1;
  int m = millis();
  if (m - lastm > 1000 * fint) {
    frate = float(fcount) / fint;
    fcount = 0;
    lastm = m;
    println("fps: " + frate); 
  }
  cam.beginHUD();
  fx.render()
    .bloom(0.5, 20, 30)
    .compose();
  cam.endHUD();
}

void drawParticle(PVector center) {
  noStroke();
  
  pushMatrix();
  translate(center.x, center.y,center.z);
  stroke(255);
  tint(255);
  box(partSize);
  popMatrix();
}

void moveParticle(int index){
  positions[index].x+=random(-0.5, +0.5);
  positions[index].y+=random(-0.5, +0.5);
  positions[index].z+=random(-0.5, +0.5);
}

void initPositions() {
  positions = new PVector[npartTotal];
  for (int n = 0; n < positions.length; n++) {
    positions[n] = new PVector(random(-100, +100), random(-100, +100), random(-100, +100));
  }  
}
