import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

PShape inputModel, outputModel;
PVector[] vertici;
int numero_vertici = 0;

void setup() {
  size(800, 600, P3D);
  fx = new PostFX(this);
  inputModel = loadShape("skull.obj");
  //calcolo numero dei vertici del modello
  for (int i=0; i<inputModel.getChildCount(); i++) {
    for (int j=0; j<inputModel.getChild(i).getVertexCount(); j++) {
      numero_vertici+=1;
    }
  }
  println(numero_vertici);
  vertici = new PVector[numero_vertici];
  int contatore = 0;
  //copio i vertici in un array di pvector
  for (int i=0; i<inputModel.getChildCount(); i++) {
    for (int j=0; j<inputModel.getChild(i).getVertexCount(); j++) {
      PVector nuovoVertice = inputModel.getChild(i).getVertex(j);
      vertici[contatore] = nuovoVertice;
      contatore+=1;
    }
  }
  //ricostruisco un modello con i dati dei vertici
  //dall'array
  outputModel = createShape(PShape.GROUP);
  for(int i=0;i<vertici.length;i++){
    PShape particella = createShape();
    particella.beginShape(POINTS);
    particella.stroke(255);
    particella.strokeCap(SQUARE);
    particella.vertex(vertici[i].x,vertici[i].y,vertici[i].z);
    particella.endShape();
    outputModel.addChild(particella);
  }
  //outputModel.endShape();
}

float angolo =0.0;

void draw(){
  background(0);
  lights();
  
  translate(width/2,100+height/2);
  rotateY(angolo);
  rotateZ(PI);
  scale(50);
  shape(outputModel,0,0);
  
  angolo+=0.01;
  
  fx.render().sobel().bloom(0.5,20,30).compose();
}
