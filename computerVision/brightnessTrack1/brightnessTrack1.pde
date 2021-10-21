import processing.video.*;

Capture webcam;

void setup(){
  size(640,480);
  webcam = new Capture(this,width,height);
  webcam.start();
}


void draw(){
  if(webcam.available()){
    webcam.read();
    image(webcam,0,0);
    float luminosita,piu_luminoso=0;
    int coordX=0,coordY=0;
    int contatore=0;
    for(int y=0;y<webcam.height;y++){
      for(int x=0;x<webcam.width;x++){
          luminosita = brightness(webcam.pixels[contatore]);
          if(luminosita>piu_luminoso){
            piu_luminoso = luminosita;
            coordX = x;
            coordY = y;
          }
          contatore++;
        }
    }
    fill(255,0,0);
    ellipse(coordX,coordY,20,20);
  }
}
