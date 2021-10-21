import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import processing.video.*;

Movie m1,m2;
int RED =0,GREEN=255,BLUE=0;
float THRESHOLD_COLORE = 100;
PImage p,sfondo;

int blurA = 0, blurB=0;


void setup(){
  size(960,540);
  m1 = new Movie(this,"profileGS.mov");
  m1.loop();
  m2 = new Movie(this,"home.mov");
  m2.loop();
  p = createImage(1280,720,ARGB);
  sfondo = loadImage("image.jpg");
  sfondo.loadPixels();
}

void draw(){
  m1.loadPixels();
  m2.loadPixels();
  p.loadPixels();
  
  for(int i=0;i<m1.width;i++){
    for(int j=0;j<m1.height;j++){
      color c = m1.pixels[i+j*m1.width];
      float distanza = dist(red(c),green(c),blue(c),RED,GREEN,BLUE);
      if(distanza<THRESHOLD_COLORE){
        p.pixels[i+j*m1.width] = sfondo.pixels[i+j*m1.width];
      }
      else{
        color c2 = c;
        color nuovo_colore = color(  
            red(c2),green(c2),blue(c2),distanza-THRESHOLD_COLORE
          );
        p.pixels[i+j*m1.width] = nuovo_colore;
      }
    }
  }
  p.updatePixels();
  
  image(m2,0,0,width,height);
  image(p,0,0,width,height);
  
  filter(BLUR, 1);
}

void movieEvent(Movie m){
  if(m==m1)
    m1.read();
  if(m==m2)
    m2.read();
      
}

void mouseMoved(){
  THRESHOLD_COLORE = mouseX;
}

void mouseClicked(){
  THRESHOLD_COLORE = mouseX;
  println(THRESHOLD_COLORE);
}
