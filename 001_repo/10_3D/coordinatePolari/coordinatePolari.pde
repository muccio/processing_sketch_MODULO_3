import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import processing.sound.*;

float angolo = 0.0;
AudioIn in;
FFT fft;
float[] bins;
Amplitude amp;
float zoom = 100;
PostFX fx;

void setup() {
  size(800, 800, P3D);
  in = new AudioIn(this, 0);
  in.start();
  fft = new FFT(this, 512);
  fft.input(in);
  bins = new float[512];
  amp = new Amplitude(this);
  amp.input(in);
  fx = new PostFX(this);
  textSize(80);
  textMode(SHAPE);
  textAlign(CENTER,CENTER);
}

float textz = -200;

void draw() {
  fft.analyze(bins);
  zoom = 100 + amp.analyze()*300;
  background(0);
  pushMatrix();
  translate(width/2, height/2, zoom);
  rotateX(angolo);
  rotateY(angolo);
  rotateZ(angolo);
  lights();
  noStroke();
  fill(0);
  sphere(100);
  disegnaRiccio(100, 32, color(0, 255, 0));
  angolo+=0.001;
  popMatrix();
  stroke(255);
  fill(255);
  text("TESTO",width/2,height/2,textz);
  textz++;
  if(textz>500)textz=-200;
  fx.render().bloom(0.5,50,40).compose();
}

void disegnaRiccio(int raggio, int tot, color c) {
  int counter = 0;
  for (int i=0; i<tot; i++) {
    float lon = map(i, 0, tot, -PI, PI);
    for (int j=0; j<tot; j++) {
      float moltiplicatore = bins[50+counter];
      float raggio_dinamico = raggio + raggio*moltiplicatore;
      float lat = map(j, 0, tot, -HALF_PI, HALF_PI);
      float x = raggio_dinamico * sin(lon) * cos(lat);
      float y = raggio_dinamico * sin(lon) * sin(lat);
      float z = raggio_dinamico * cos(lon);
      //strokeWeight(3);
      stroke(0);
      beginShape(LINES);
      vertex(x, y, z);
      stroke(c, 150);
      vertex(x*1.20, y*1.20, z*1.20);
      stroke(c, 255);
      vertex(x*1.40, y*1.40, z*1.40);
      stroke(255, 255);
      vertex(x*1.45, y*1.45, z*1.45);
      endShape();
      //point(x,y,z);
      counter++;
      if (counter>256) {
        counter = 0;
      }
    }
  }
}


/*
coordinate polari in 3d
 x = r * sin a * cos b
 y = r * sin a * sin b
 z = r * cos a
 
 a: longitutdine
 b: latitudine
 */
