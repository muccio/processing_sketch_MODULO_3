/*
convertire lo sketch in classe
modificare il setup della classe 
in modo da puntare allo sketch master
con il parametro PApplet e togliere 
i setSize

nel master creare le istanze 
delle scene (cioe'gli sketch secondari)
inizializzarle nel setup richiamando 
i relativi metodi setup
creare variabile globale per puntare 
lo sketch attivo
nel draw del master inserire switch
per selezionare quale sketch sara 
renderizzato con la sua draw

via osc gestire i cambi scena
ed i fade in/out
*/

import netP5.*;
import oscP5.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import processing.sound.*;
import processing.video.*;

int sketch_attivo = 0;

primoSketch p;
coordinatePolari c;
videoSlices v;
shaderino s;
sketch_rete_pallette r;

OscP5 oscP5;

void setup() {
  size(960, 540, P3D);
  //istanza del primo sketch
  p = new primoSketch();
  p.setup();
  //istanza del secondo
  c = new coordinatePolari();
  c.setup(this);
  //istanza del terzo
  v = new videoSlices();
  v.setup(this);
  //istanza del quarto
  s = new shaderino();
  s.setup();
  //istanza del quinto
  r = new sketch_rete_pallette();
  r.setup(this);
  r.addPallette();
  //inizializzazione libreria osc
  oscP5 = new OscP5(this, 8000);
}

void draw() {
  switch(sketch_attivo) {
  case 1:
    p.draw();
    break;
  case 2:
    c.draw();
    break;
  case 3:
    v.draw();
    break;
  case 4:
    s.draw();
    break;
  case 5:
    r.draw();
    break;
  }
  fade();
}


void oscEvent(OscMessage messaggio) {
  String addressPattern = messaggio.addrPattern();
  String tipo = messaggio.typetag();
  println(addressPattern+" "+tipo);
  if (messaggio.checkAddrPattern("/scena")) {
    sketch_attivo = messaggio.get(0).intValue();
  }
  if (messaggio.checkAddrPattern("/slices")) {
    v.numero_fettine = messaggio.get(0).intValue();
  }
  if (messaggio.checkAddrPattern("/fade")) {
    switch(messaggio.get(0).stringValue()) {
    case "in":
      fade_out = false;
      break;
    case "out":
      fade_out = true;
      break;
    }
  }
}

/*
void keyPressed(){
 switch(key){
 case '1':
 sketch_attivo = 1;
 break;
 case '2':
 sketch_attivo = 2;
 break;
 case 'o':
 fade_out = true;
 break;
 case 'i':
 fade_out = false;
 break;
 }
 }*/

float opacita_per_fade = 0;
boolean fade_out = false;

void fade() {
  if (fade_out)
    opacita_per_fade+=4;
  else
    opacita_per_fade-=4;
  opacita_per_fade = constrain(opacita_per_fade, 0, 255);
  noStroke();
  fill(0, opacita_per_fade);
  hint(DISABLE_DEPTH_TEST);
  rect(0, 0, width*4, height*4);
}

void movieEvent(Movie pippo) {
  v.movieEvent(pippo);
}
