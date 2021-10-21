import processing.video.*;

//Movie m;
Capture m;

int RED=255;
int GREEN=255;
int BLUE=255;
float COLOR_THRESHOLD=0.3;
float DISTANCE_THRESHOLD=10;

ArrayList<PVector> array_punti;

void setup(){
  size(640,480);
  frameRate(30);
  smooth();
  m = new Capture(this, width, height);
  m.start(); 
  array_punti = new ArrayList<PVector>();
}


void draw(){
  background(0);
  if (m.available()) {
    m.read();
    m.loadPixels();
    //image( m, 0, 0, width, height );
    //filter(THRESHOLD,COLOR_THRESHOLD);
    //filter(INVERT);
    int white_counter = 0;
    int conta_punti = 0;
    //prende un punto bianco ogni 16 (%16)
    //e lo aggiunge all'array
    for(int i=0;i<width;i++){
      for(int j=0;j<height;j++){
        color c = m.pixels[i+j*width];
        if(brightness(c)>100){
          white_counter++;
          try{
          if(white_counter%mouseX==0){
            if(conta_punti<32768){
              //array_punti.add(new PVector(i,j));
              //conta_punti++;
              noStroke();
              fill(255,brightness(c));
              ellipse(i,j,brightness(c)/100,brightness(c)/100);
            }
          }
          }
          catch(Exception x){}
        }
      }
    }
  }
}

void mouseMoved(){
  COLOR_THRESHOLD = (float)mouseX/(float)width;
  DISTANCE_THRESHOLD = (float)mouseY;
}
