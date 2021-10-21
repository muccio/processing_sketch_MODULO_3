import processing.video.*;

Capture webcam;

int soglia;

color tracciamento;
float trackR,trackG,trackB;

int topLeftX=width,topLeftY=height;
int bottomRightX=0,bottomRightY=0;

void setup(){
  size(640,480);
  webcam = new Capture(this,width,height);
  webcam.start();
  tracciamento = color(255);
  trackR = red(tracciamento);
  trackG = green(tracciamento);
  trackB = blue(tracciamento);
  soglia = 40;
}

void draw(){
  //background(255);
  if(webcam.available()){
    webcam.read();
    image(webcam,0,0);
    loadPixels();
    int counter = 0;
    for(int j=0;j<webcam.height;j++){
      for(int i=0;i<webcam.width;i++){
        color c = webcam.pixels[counter];
        float r = red(c);
        float g = green(c);
        float b = blue(c);
        float distanza_del_colore = dist(r,g,b ,trackR,trackG,trackB);
        if(distanza_del_colore<soglia){
            if(i<topLeftX){  topLeftX = i; }
            if(j<topLeftY){  topLeftY = j; }
            if(i>bottomRightX){  bottomRightX = i; }
            if(j>bottomRightY){  bottomRightY = j; }
        }
        counter++;
      }
    }
    updatePixels();
  }
  //DISEGNA AREA DI RICONOSCIMENTO
  strokeWeight(2);
  stroke(tracciamento);
  noFill();
  rect(topLeftX,topLeftY,bottomRightX-topLeftX,bottomRightY-topLeftY);
  //inizializzo i valori 
  topLeftX=width;
  topLeftY=height;
  bottomRightX=0;
  bottomRightY=0;
  //VISUALIZZA LA SOGLIA IN ALTO A SX
  fill(255);
  rect(0,0,100,30);
  fill(255,0,0);
  text("soglia: "+soglia,10,20);
}

void mousePressed(){
  tracciamento = webcam.get(mouseX,mouseY);
  trackR = red(tracciamento);
  trackG = green(tracciamento);
  trackB = blue(tracciamento);
}

void keyPressed(){
  if(keyCode==UP){
    soglia++;
  }
  if(keyCode==DOWN){
    soglia--;
  }
}
