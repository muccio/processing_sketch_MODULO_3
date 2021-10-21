import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import peasy.*;

PostFX fx;
PeasyCam camera;

int numero_particelle = 5000;
PVector[] posizioni;
int dimensione_particella = 1;

void setup() {
  size(600, 600, P3D);
  fx = new PostFX(this);
  camera = new PeasyCam(this,300);
  inizializzaPosizioni();
}
float lastm=0;
void draw() {
  background(0);
  lights();
  
  for(int n=0;n<numero_particelle;n++){
    muoviParticella(n);
    disegnaParticella(posizioni[n]);
  }
  fx.render().sobel().bloom(0.5,20,30).compose();
  
  //calcolo framerate
  int m=millis();
  float scarto = m-lastm;
  float fps = 1000/scarto;
  text(fps,100,100);
  lastm=m;
}

void disegnaParticella(PVector centro){
  noStroke();
  pushMatrix();
  translate(centro.x,centro.y,centro.z);
  fill(255);
  box(dimensione_particella);
  popMatrix();
}

void muoviParticella(int indice){
  posizioni[indice].x += random(-0.5,0.5);
  posizioni[indice].y += random(-0.5,0.5);
  posizioni[indice].z += random(-0.5,0.5);
}

void inizializzaPosizioni() {
  posizioni = new PVector[numero_particelle];
  for (int i=0; i<posizioni.length; i++) {
    posizioni[i] = new PVector(
      random(-50, 75), 
      random(-76, 30), 
      random(-23, 50)
      );
  }
}
