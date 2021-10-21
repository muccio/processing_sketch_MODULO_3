import processing.video.*;

Capture webcam;

int soglia;

int topLeftX=width,topLeftY=height;
int bottomRightX=0,bottomRightY=0;

void setup(){
  size(640,480);
  println(Capture.list());
  webcam = new Capture(this,width,height);
  webcam.start();
  
  soglia = 220;
}

void draw(){
  //background(255);
  if(webcam.available()){
    webcam.read();
    image(webcam,0,0);
    loadPixels();
    /*float luminosita;
    for(int i=0;i<webcam.width*webcam.height;i++){
      luminosita = brightness(webcam.pixels[i]);
      if(luminosita>soglia){
          pixels[i] = color(255);
      }
      else{
          pixels[i] = color(0);
      }
    }
    */
    int counter = 0;
    for(int j=0;j<webcam.height;j++){
      for(int i=0;i<webcam.width;i++){
        color c = webcam.pixels[counter];
        float luminosita = brightness(c);
        if(luminosita>soglia){
            pixels[counter] = color(255);
            topLeftX = min(i,topLeftX);
            topLeftY = min(j,topLeftY);
            bottomRightX = max(i,bottomRightX);
            bottomRightY = max(j,bottomRightY);
        }
        else{
            pixels[counter] = color(0);
        }
        counter++;
      }
    }
    updatePixels();
  }
  //DISEGNA AREA DI RICONOSCIMENTO
  strokeWeight(2);
  stroke(255,0,0);
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

void keyPressed(){
  if(keyCode==UP){
    soglia++;
  }
  if(keyCode==DOWN){
    soglia--;
  }
}
