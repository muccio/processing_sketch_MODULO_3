import nervoussystem.obj.*;

/*
PShape modello3d;
 float angolo = 0.0;
 
 void setup(){
 size(600,600,P3D);
 modello3d = loadShape("skull.obj");
 }
 
 void draw(){
 background(0);
 lights();
 directionalLight(255,255,255,0,1,0);
 translate(width/2,height/2);
 scale(30);
 rotateX(angolo);
 rotateY(angolo);
 rotateZ(angolo);
 shape(modello3d,0,0);
 angolo+=0.01;
 }
 */
/*
float angolo=0.0;
 boolean inizia=false;
 
 void setup(){
 size(600,600,P3D);
 }
 
 void draw(){
 background(0);
 lights();
 if(inizia)
 beginRecord("nervoussystem.obj.OBJExport","nomefile.obj");
 translate(width/2,height/2);
 rotateY(angolo);
 rotateZ(angolo);
 noStroke();
 fill(0,255,0);
 //box(100,100,100);
 scale(2);
 for(float x=0;x<2*PI;x+=PI/8){
 rotateX(x);
 rotateY(x);
 fill(255,0,0);
 box(x*10,99,99);
 println(x);
 }
 angolo+=0.01;
 if(inizia){
 endRecord();
 inizia = false;
 }
 }
 
 void keyPressed(){
 if(key=='s'){
 inizia=true;
 }
 }
 */
float angolo=0.0;
boolean inizia=false;

void setup() {
  surface.setResizable(true);
  size(600, 600, P3D);
}

void draw() {
  background(0);
  lights();
  if (inizia)
    beginRecord("nervoussystem.obj.OBJExport", "nomefile.obj");
  translate(width/2, height/2);
  rotateY(angolo);
  rotateZ(angolo);
  noStroke();
  sphereDetail(10);
  for (int z=0; z<10; z++) {
    for (int y=0; y<10; y++) {
      for (int x=0; x<10; x++) {
        pushMatrix();
        translate(x*30, y*30, z*30);
        sphere(10);
        popMatrix();
      }
    }
  }

  angolo+=0.01;
  if (inizia) {
    endRecord();
    inizia = false;
  }
}

void keyPressed() {
  if (key=='s') {
    inizia=true;
  }
}
