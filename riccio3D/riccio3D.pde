import netP5.*;
import oscP5.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import processing.sound.*;

float angolo_x = 0.0;
float angolo_y = 0.0;
float angolo_z = 0.0;
AudioIn in;
Amplitude amp;
PostFX fx;
OscP5 osc;
FFT fft;
float[] bins;


void setup() {
  size(800, 800, P3D);
  frameRate(30);
  in = new AudioIn(this, 0);
  amp = new Amplitude(this);
  amp.input(in);
  fx = new PostFX(this);
  osc = new OscP5(this, 8000);
  fft = new FFT(this,512);
  fft.input(in);
  bins = new float[512];
}

void draw() {
  fft.analyze(bins);
  background(0);
  pushMatrix();
  translate(width/2, height/2, 100);
  rotateX(angolo_x);
  rotateY(angolo_y);
  rotateZ(angolo_z);
  lights();
  noStroke();
  fill(0);
  int ampiezza = 100;// + int(amp.analyze()*600);
  sphere(ampiezza);
  //println(ampiezza);
  disegnaRiccio(ampiezza, color(0, 255, ampiezza), 32);
  popMatrix();
  fx.render().bloom(0.11, 200, 100*amp.analyze()).compose();
}
/*
coordinate polari in 3d
 x = r * sin a * cos b
 y = r * sin a * sin b
 z = r * cos a
 
 a: longitudine
 b: latitudine
 */
void disegnaRiccio(int raggio, color c, int totale) {
  int conta_bin = 50;
  color colore = c;
  for (int i=0; i<totale; i++) {
    float lon = map(i, 0, totale, -PI, PI);
    for (int j=0; j<totale; j++) {
      float valore_del_bin = bins[conta_bin];
      //println(valore_del_bin);
      float raggio_bin = raggio+valore_del_bin*raggio*1000;
      float lat = map(j, 0, totale, -HALF_PI, HALF_PI);
      float x = raggio_bin * sin(lon) * cos(lat);
      float y = raggio_bin * sin(lon) * sin(lat);
      float z = raggio_bin * cos(lon);

      stroke(0);
      beginShape(LINES);
      vertex(x, y, z);
      stroke(color(red(c)+i*4,green(c),blue(c)), 150);
      vertex(x*1.20, y*1.20, z*1.20);
      stroke(color(red(c),green(c),blue(c)+j*4), 190);
      vertex(x*1.40, y*1.40, z*1.40);
      stroke(color(red(c)+i*4,green(c),blue(c)+j*4), 255);
      vertex(x*1.60, y*1.60, z*1.60);
      endShape();
      
      conta_bin++;
      conta_bin = constrain(conta_bin,0,256);
    }
  }
}

void oscEvent(OscMessage il_messaggio_da_max) {
  String path = il_messaggio_da_max.addrPattern();
  float valore = il_messaggio_da_max.get(0).floatValue();
  if (path.equals("/rotazionex")) {
    angolo_x = valore;

    println("rotazionex");
  }
  if (path.equals("/rotazioney")) {
    angolo_y = valore;
  }
  if (path.equals("/rotazionez")) {
    angolo_z = valore;
  }
}
