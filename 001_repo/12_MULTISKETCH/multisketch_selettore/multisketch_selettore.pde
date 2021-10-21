import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import processing.sound.*;
import peasy.*;
import javax.swing.*;

sketch_sfera sf;
sketch_rete_pallette rp;

int sketch_attivo = 0;

void setup() {
  size(800, 800, P3D);
  sf = new sketch_sfera();
  sf.setup(this);
  rp = new sketch_rete_pallette();
  rp.setup(this);
  setTimeout("lateInitSketchPallette", 50);
}

void draw() {
  switch(sketch_attivo) {
  case 1:
    sf.draw();
    break;
  case 2:
    rp.draw();
    break;
  default:
    break;
  }
}

void keyPressed() {
  switch(key) {
  case '1':
    sketch_attivo = 1;
    break;
  case '2':
    sketch_attivo = 2;
    break;
  }
  switch (sketch_attivo) {
  case 1:
    sf.keyPressed();
    break;
  case 2:
    rp.keyPressed();
    break;
  default:
    break;
  }
}


void mousePressed() {
  switch(sketch_attivo) {
  case 1:
    break;
  case 2:
    rp.mousePressed();
    break;
  default:
    break;
  }
}
