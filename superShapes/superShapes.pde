import peasy.*;
import processing.sound.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;


PostFX fx;
AudioIn in;
Amplitude amp;
float a = 1;
float b = 0.5;
float m = 0;
float incremento_m = 0;
int totale = 128;
PVector[][] lista_punti;
PeasyCam camera;

void setup() {
  size(600, 600, P3D);
  camera = new PeasyCam(this,500);
  lista_punti = new PVector[totale+1][totale+1];
  in = new AudioIn(this, 0);
  amp = new Amplitude(this);
  amp.input(in);
  fx = new PostFX(this);
}

void draw() {
  a = 1;//map(mouseX,0,width,0,1);
  b = 1;//map(mouseY,0,height,0,1);
  m = map(sin(incremento_m), -1, 1, 0, 7);
  float base = 13;//map(mouseX,0,width,0,100);
  incremento_m = base+5*amp.analyze();//0.02;
  
  background(0);
  noStroke();
  lights();
  float raggio = 200;
  for (int i=0; i<totale+1; i++) {
    float lon = map(i, 0, totale, -PI, PI);
    float r2 = superFormula(lon, m, 0.2, 1.7, 1.7);
    for (int j=0; j<totale+1; j++) {
      float lat = map(j, 0, totale, -HALF_PI, HALF_PI);
      float r1 = superFormula(lon, m, 0.2, 1.7, 1.7);
      float x = raggio *r1* sin(lon) *r2* cos(lat);
      float y = raggio *r1* sin(lon) *r2* sin(lat);
      float z = raggio *r2* cos(lon);
      lista_punti[i][j] = new PVector(x, y, z);
    }
  }
  //translate(width/2,height/2);
  //disegno
  for (int i=0; i<totale; i++) {
    float hsb = map(i,0,totale,0,255);
    fill(hsb,255,255);
    beginShape(TRIANGLE_STRIP);
    for (int j=0; j<totale+1; j++) {
      PVector v1 = lista_punti[i][j];
      vertex(v1.x,v1.y,v1.z);
      PVector v2 = lista_punti[i+1][j];
      vertex(v2.x,v2.y,v2.z);
    }
    endShape();
  }
  camera.beginHUD();
  fx.render().bloom(0.11, 200, 100).compose();
  camera.endHUD();
}

float superFormula(float theta, float m, float n1, float n2, float n3) {
  float risultato=0;
  float termine_1 = abs((1/a)*cos(m*theta/4));
  termine_1 = pow(termine_1, n2);
  float termine_2 = abs((1/b)*sin(m*theta/4));
  termine_2 = pow(termine_2, n3);
  float termine_3 = termine_1+termine_2;
  risultato = pow(termine_3, -1/n1);
  return risultato;
}
