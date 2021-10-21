//cilindro + audio + cambio forma ogni 50 frame

import processing.sound.*;

AudioIn in;
Amplitude amp;

void setup(){
  size(400,400,P3D);
  frameRate(25);
  in = new AudioIn(this);
  in.start();
  amp = new Amplitude(this);
  amp.input(in);
}

float raggioS =0;
float raggioI =0;
float alt =0;
float fac =0;

color c = color(255,255,255);
float angoloY = 0.0,angoloZ = 0.0;

void draw(){
  background(0);
  pointLight(255,255,255,
        width/2,height/2,50
        );
  translate(width/2,height/2,amp.analyze()*-300);
  
  noStroke();
  rotateY(angoloY);
  rotateZ(angoloZ);
  if(frameCount%50==0){
    raggioS = random(1,200);
    raggioI = random(1,200);
    alt = random(1,200);
    fac = random(1,200);
    c = color(random(255),random(255),random(255));
  }
  fill(c);
  disegnaCilindro(raggioS,raggioI,alt,fac);
  angoloY+=0.01;
  angoloZ+=0.01;
}

void disegnaCilindro(float raggioSup,float raggioInf,float altezza,float facce){
  float angolo = 0;
  float incremento = TWO_PI/facce;
  beginShape(QUAD_STRIP);
  for(int i=0;i<facce+1;i++){
    vertex(raggioSup*cos(angolo),0,raggioSup*sin(angolo));
    vertex(raggioInf*cos(angolo),altezza,raggioInf*sin(angolo));
    angolo+=incremento;
  }
  endShape();
  if(raggioSup!=0){
    angolo = 0;
    beginShape(TRIANGLE_FAN);
    for(int i=0;i<facce+1;i++){
      vertex(raggioSup*cos(angolo),0,raggioSup*sin(angolo));
      angolo+=incremento;
    }
    endShape();
  }
  if(raggioInf!=0){
    angolo = 0;
    beginShape(TRIANGLE_FAN);
    for(int i=0;i<facce+1;i++){
      vertex(raggioInf*cos(angolo),altezza,raggioInf*sin(angolo));
      angolo+=incremento;
    }
    endShape();
  }
}
