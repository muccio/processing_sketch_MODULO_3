import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import processing.sound.*;

PostFX fx;

Amplitude amp;
AudioIn in;
FFT fft;
float[] bins;
float angolo = 0.0;
ArrayList<sponge> frattale;
sponge origine;

void setup() {
  size(800, 800, P3D);
  frattale = new ArrayList<sponge>();
  origine = new sponge(0, 0, 0, 400);
  frattale.add(origine);
  in = new AudioIn(this, 0);
  amp = new Amplitude(this);
  amp.input(in);
  fft = new FFT(this, 512);
  fft.input(in);
  bins = new float[512];
  for (int i=0; i<3; i++) {
    generaDivisione();
  }
  fx = new PostFX(this);
}

void draw() {
  fft.analyze(bins);
  background(0);
  stroke(255,0,0,120);
  fill(126,0,0, 120);
  lights();
  translate(width/2, height/2);
  rotateX(angolo);
  rotateY(angolo);
  rotateZ(angolo);

  angolo+=0.01;

  for(int c=0;c<frattale.size();c++){
    sponge s = frattale.get(c);
    s.disegna();
    s.r = constrain(20*bins[c]*10000,10,100);
  }
  
  
  fx.render().bloom(0.11, 200, 100*amp.analyze()).compose();
}


class sponge {
  float x;
  float y;
  float z;
  float r;

  sponge(float x_par, float y_par, float z_par, float r_par) {
    x=x_par;
    y=y_par;
    z=z_par;
    r=r_par;
  }

  void disegna() {
    pushMatrix();
    translate(x, y, z);
    rotateX(z);
    rotateY(y);
    rotateZ(x);
    box(r);
    popMatrix();
  }

  ArrayList<sponge> generaSottoCubi() {
    ArrayList<sponge> cubi = new ArrayList<sponge>();
    for (int cx=-1; cx<2; cx++) {
      for (int cy=-1; cy<2; cy++) {
        for (int cz=-1; cz<2; cz++) {
          float dimensione = r/3;
          sponge cubetto = new sponge(x+cx*dimensione, 
            y+cy*dimensione, 
            z+cz*dimensione, 
            dimensione);
          if (!(abs(cx)+abs(cy)+abs(cz)>1))
            //if (abs(cx)+abs(cy)+abs(cz)>1)
            //if (abs(cx)>=1&&abs(cy)!=0&&abs(cz)!=1)
            cubi.add(cubetto);
        }
      }
    }
    return cubi;
  }
}

void generaDivisione() {
  ArrayList<sponge> nuova_generazione = new ArrayList<sponge>();
  for (sponge s : frattale) {
    nuova_generazione.addAll(s.generaSottoCubi());
  }
  frattale = nuova_generazione;
  println(frattale.size());
}
