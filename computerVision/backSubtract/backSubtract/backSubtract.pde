import processing.video.*;

Capture webcam;
int[] sfondo;
int soglia = 5000000;

void setup(){
  size(640,480);
  webcam = new Capture(this,width,height);
  webcam.start();
  sfondo = new int[width*height];
}

void draw(){
  //background(255);
  loadPixels();
  if(webcam.available()){
    webcam.read();
    webcam.loadPixels();
    int movimento = 0;
    for(int i=0;i<webcam.width*webcam.height;i++){
      //primo fotogramma che arriva dalla webcam
      if(sfondo==null){
        return;
      }
      color coloreCorrente = webcam.pixels[i];
      color coloreDiSfondo = sfondo[i];
      //calcolare i singoli canali per i pixel corrente e precedente
      float currR = red(coloreCorrente);
      float currG = green(coloreCorrente);
      float currB = blue(coloreCorrente);
      float prevR = red(coloreDiSfondo);
      float prevG = green(coloreDiSfondo);
      float prevB = blue(coloreDiSfondo);
      //differenza dei valori
      float diffR = abs(currR-prevR);
      float diffG = abs(currG-prevG);
      float diffB = abs(currB-prevB);
      
      movimento += diffR +diffG +diffB;
      pixels[i] = color(diffR,diffG,diffB);
      
    }
    if(movimento>0){
      updatePixels();
      fill(255);
      rectMode(CORNER);
      rect(0,0,100,20);
      fill(255,0,0);
      text("mov:"+movimento,10,10);
      println(movimento);
    }
  }
}

void keyPressed(){
  webcam.loadPixels();
  arraycopy(webcam.pixels,sfondo);
}
