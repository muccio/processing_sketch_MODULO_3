import processing.video.*;

Capture webcam;
int[] fotogrammaPrecedente;
int soglia = 5000000;

void setup(){
  size(640,480);
  webcam = new Capture(this,width,height);
  webcam.start();
  fotogrammaPrecedente = new int[width*height];
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
      if(fotogrammaPrecedente==null){
        return;
      }
      color coloreCorrente = webcam.pixels[i];
      color colorePrecedente = fotogrammaPrecedente[i];
      //calcolare i singoli canali per i pixel corrente e precedente
      float currR = red(coloreCorrente);
      float currG = green(coloreCorrente);
      float currB = blue(coloreCorrente);
      float prevR = red(colorePrecedente);
      float prevG = green(colorePrecedente);
      float prevB = blue(colorePrecedente);
      //differenza dei valori
      float diffR = abs(currR-prevR);
      float diffG = abs(currG-prevG);
      float diffB = abs(currB-prevB);
      
      movimento += diffR +diffG +diffB;
      pixels[i] = color(diffR,diffG,diffB);
      fotogrammaPrecedente[i] = coloreCorrente;
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
    if(movimento>soglia){
      fill(255);
      rectMode(CENTER);
      rect(width/2,height/2,100,100);
    }
  }
}
