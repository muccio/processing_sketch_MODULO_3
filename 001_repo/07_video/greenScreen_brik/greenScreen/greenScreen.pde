import processing.video.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;
PImage p;
PImage bg;
Movie m,m2;
int blurA = 5;
float blurB = 5.0;
int RED=0;
int GREEN=255;
int BLUE=0;
float COLOR_THRESHOLD=100;

String alfabeth = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String testo="";

void setup(){
  size(960,540,P2D);
  smooth();
  m = new Movie( this, "fumoGS.mov" );
  m.loop();
  m2 = new Movie( this, "home.mov" );
  m2.loop();
  m.speed(1.0);
  p = createImage(1280,720,ARGB);
  bg = loadImage("image.jpg");
  bg.loadPixels();
  fx = new PostFX(this); 
  
}

void movieEvent( Movie m ){
    m.read();
    m2.read();
}

void draw(){
  background( 0 );
  if(!m.available())
  return;
  if(!m2.available())
  return;
  m.filter(GRAY);
  m.loadPixels();
  m2.loadPixels();
  p.loadPixels();
  for(int i=0;i<m.width;i++){
    for(int j=0;j<m.height;j++){
      color c = m.pixels[i+j*m.width];
      float cDista=dist(red(c),green(c),blue(c),RED,GREEN,BLUE);
      if(cDista<COLOR_THRESHOLD){
        p.pixels[i+j*m.width] = color(0);
      }
      else{
        //color bg_c = bg.pixels[i+j*m.width];
        color bg_c = m2.pixels[i+j*m2.width];
        color new_c = color(red(bg_c),green(bg_c),blue(bg_c),cDista-COLOR_THRESHOLD);
        p.pixels[i+j*m.width] = new_c;
      }
    }
  }
  p.updatePixels();
  image( p, 0, 0, width, height );
  
  fx.render().blur(blurA,blurB).compose();
    
  textSize(12);
  text(COLOR_THRESHOLD,30,30);

  stroke(255);
  
  textSize(20);
  if(frameCount%2==0)
    testo = alfabeth.charAt(int(random(alfabeth.length())))+ "" + alfabeth.charAt(int(random(alfabeth.length()))) + 
                 "->" + random(255) + "." + random(255);
  text(testo,width-300,40);
}

void mouseMoved(){
  blurA = mouseX;
  blurB = mouseY;
}

void mouseClicked(){
  COLOR_THRESHOLD = mouseX;
}
