PShape inputModel,outputModel,selected; //<>//
PVector[] vexArray;
int vertexCounter = 0;
float ang = 0.0;

public void settings() {
  size(800, 600, P3D);
}

public void setup() {
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
       if(i>8000)
         vexArray[iter] = newVex.add(new PVector(random(0.4),random(2.0),random(0.4)));
       iter+=1;
     }
   }
   outputModel = createShape();
   outputModel.beginShape(TRIANGLE);
   outputModel.noStroke();
   outputModel.scale(40);
   for (int i = 0; i < vexArray.length; i++) {
     outputModel.vertex(vexArray[i].x,vexArray[i].y,vexArray[i].z);
   }
   outputModel.endShape();
   
   selected = inputModel;
}

public void draw() {
  background(0);
  directionalLight(0, 255, 0, 0, -1, 0);
  directionalLight(0, 255, 0, -1, 1, 0);
  pushMatrix();
  translate(width/2, 100+height/2,mouseX);
  rotateY(radians(ang));
  rotateZ(PI);
  shape(selected);
  popMatrix();
  ang+=0.1;
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
