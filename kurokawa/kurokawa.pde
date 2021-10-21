import processing.video.*;

Capture webcam;
Movie filmato;

float COLOR_THRESHOLD = 0.02;
float DISTANCE_THRESHOLD = 22;
ArrayList<PVector> array_dei_punti;

void setup() {
  size(1280, 720);
  webcam = new Capture(this);
  //webcam.start();
  array_dei_punti = new ArrayList<PVector>();
  filmato = new Movie(this, "citta.mp4");
  filmato.loop();
}

void draw() {
  if (filmato.available()) {
    filmato.read();
    lineePazze(filmato);
  }
  //background(0);
  if (webcam.available()) {
    webcam.read();
    lineePazze(webcam);
  }
  stroke(255);
  fill(255);
  text( "COLOR_THRESHOLD="+COLOR_THRESHOLD,100,100);
  text( "DISTANCE_THRESHOLD="+DISTANCE_THRESHOLD,100,150);
  saveFrame();
}

void lineePazze(PImage sorgente) {
  sorgente.loadPixels();
  sorgente.filter(THRESHOLD, COLOR_THRESHOLD);
  sorgente.filter(INVERT);
  image(sorgente, 0, 0, sorgente.width, sorgente.height);
  int conta_bianchi = 0;
  int conta_punti = 0;
  for (int x=0; x<sorgente.width; x++) {
    for (int y=0; y<sorgente.height; y++) {
      color c = sorgente.pixels[x+y*sorgente.width];
      //il bianco e'255,255,255
      //testo solo la prima componente del colore
      if (red(c)==255) {
        conta_bianchi++;
        if (conta_bianchi%16==0) {
          array_dei_punti.add(new PVector(x, y));
          conta_punti++;
        }
      }
    }
  }
  fill(0, 200);
  rect(0, 0, sorgente.width, sorgente.height);
  //disegna le righe in base alla soglia della distanza
  while (array_dei_punti.size()>0) {
    int primo_indice = int(random(0, array_dei_punti.size()-1));
    PVector p1 = array_dei_punti.get(primo_indice);
    PVector p2;
    int secondo_indice = 0;
    for (int i=0; i<array_dei_punti.size(); i++) {
      p2 =  array_dei_punti.get(i);
      if (dist(p1.x, p1.y, p2.x, p2.y)>=1 &&
        dist(p1.x, p1.y, p2.x, p2.y)<=15) {
        secondo_indice = i;
        break;
      }
    }
    p2 = array_dei_punti.get(secondo_indice);
    stroke(255, 126);
    //
    if (dist(p1.x, p1.y, p2.x, p2.y)<DISTANCE_THRESHOLD) {
      line(p1.x, p1.y, p2.x, p2.y);
    }
    if (primo_indice<array_dei_punti.size()) {
      array_dei_punti.remove(primo_indice);
    }
    if (secondo_indice<array_dei_punti.size()) {
      array_dei_punti.remove(secondo_indice);
    }
  }
}

void mousePressed() {
  DISTANCE_THRESHOLD = mouseY;
  COLOR_THRESHOLD = map(mouseX,0,width,0,1);
}
