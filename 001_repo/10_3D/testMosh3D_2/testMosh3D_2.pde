import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PShape inputModel,outputModel,selected;
PVector[] vexArray;
int vertexCounter = 0;
float ang = 0.0;
PostFX fx;

public void setup() {
  size(800, 600, P3D);
  fx = new PostFX(this);
  randomSeed(0);
  inputModel = loadShape("skull.obj");
   for (int i = 0; i < inputModel.getChildCount(); i++) {
     for (int j = 0; j < inputModel.getChild(i).getVertexCount(); j++) {
       vertexCounter += 1;
     }
   }
   inputModel.scale(40);
   vexArray = new PVector[vertexCounter];
   int iter = 0;
   println(inputModel.getChildCount());
   for (int i = 0; i < inputModel.getChildCount(); i++) {
     for (int j = 0; j < inputModel.getChild(i).getVertexCount(); j++) {
       PVector newVex = inputModel.getChild(i).getVertex(j);
       vexArray[iter] = newVex;
       iter+=1;
     }
   }
   outputModel = createShape(PShape.GROUP);
   println("start init particles");
   for (int n = 0; n < vexArray.length; n++) {
     PShape part = createShape();
     part.beginShape(POINTS);
     part.stroke(255);
     part.strokeCap(SQUARE);
     part.vertex(vexArray[n].x,vexArray[n].y,vexArray[n].z);
     part.endShape();   
     outputModel.addChild(part);
   }
   //outputModel.scale(40);
   selected = inputModel;
}

public void draw() {
  background(0);
  lights();
  pushMatrix();
  translate(width/2, height/2 +150,0);
  rotateY(radians(ang));
  rotateZ(PI);
  if(selected==outputModel){
    scale(40);
  }
  shape(selected);
  popMatrix();
  ang+=0.1;
  fx.render()
    .sobel()
    .bloom(0.5, 20, 30)
    .compose();
}

void keyPressed(){
  switch(key){
    case '1':
      selected = inputModel;
    break;
    case '2':
      selected = outputModel;
    break;
  }
}
