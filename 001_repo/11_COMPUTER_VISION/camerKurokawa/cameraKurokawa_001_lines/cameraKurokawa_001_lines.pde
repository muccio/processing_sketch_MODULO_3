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
  if (m.available()) {
    m.read();
    m.loadPixels();
    image( m, 0, 0, width, height );
    filter(THRESHOLD,COLOR_THRESHOLD);
    filter(INVERT);
    //filtra il frame con threshold e inversione
  image( m, 0, 0, width, height );
  filter(THRESHOLD,COLOR_THRESHOLD);
  filter(INVERT);
  int white_counter = 0;
  int conta_punti = 0;
  loadPixels();
  //prende un punto bianco ogni 16 (%16)
  //e lo aggiunge all'array
  for(int i=0;i<width;i++){
    for(int j=0;j<height;j++){
      color c = pixels[i+j*width];
      if(red(c)==255){
        white_counter++;
        if(white_counter%16==0){
          if(conta_punti<32768){
            array_punti.add(new PVector(i,j));
            conta_punti++;
          }
        }
      }
    }
  }
  //copertura in trasparenza
  //del frame filtrato
  fill(0,200);
  rect(0,0,width,height);
  //ciclo di disegno righe in base alla soglia della distanza
  while(array_punti.size()>0){
    int first_index = int(random(0,array_punti.size()-1));
    PVector p1 = array_punti.get(first_index);
    PVector p2;
    int second_index = 0;
    for(int i=0;i<array_punti.size();i++){
      p2 = array_punti.get(i);
      if(dist(p1.x,p1.y,p2.x,p2.y)>=1&&dist(p1.x,p1.y,p2.x,p2.y)<=15){
        second_index =i;
        break;
      }
    }
    p2 = array_punti.get(second_index);
    stroke(255,126);
    if(dist(p1.x,p1.y,p2.x,p2.y)<DISTANCE_THRESHOLD)
      line(p1.x,p1.y,p2.x,p2.y);
    if(first_index<array_punti.size())
      array_punti.remove(first_index);
    if(second_index<array_punti.size())
      array_punti.remove(second_index);
    
  }
  }
}

void mouseMoved(){
  COLOR_THRESHOLD = (float)mouseX/(float)width;
  DISTANCE_THRESHOLD = (float)mouseY;
}
