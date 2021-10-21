PShape inputModel, outputModel;
PVector[] vertici;
int numero_vertici = 0;

void setup() {
  size(800, 600, P3D);
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
      PVector alea = new PVector(nuovoVertice.x,random(0.4),nuovoVertice.z);
      
      //se il contatore verifica una condizione
      //arbitraria, modifico il valore del vertice
      if(contatore<20000)
        vertici[contatore] = nuovoVertice.add(alea.x,alea.y,alea.z);
      else
        vertici[contatore] = nuovoVertice;
      contatore+=1;
    }
  }
  //ricostruisco un modello con i dati dei vertici
  //dall'array
  outputModel = createShape();
  outputModel.beginShape(TRIANGLE);
  outputModel.noStroke();
  for(int i=0;i<vertici.length;i++){
    outputModel.vertex(vertici[i].x,vertici[i].y,vertici[i].z);
  }
  outputModel.endShape();
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
}
