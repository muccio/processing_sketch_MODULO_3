
float tempo = 0.0;

void setup(){
  size(640,480,P3D);
}

void draw(){
  hint(ENABLE_DEPTH_TEST);
  background(255);
  lights();
  noStroke();
  pushMatrix();
    for(int i=0;i<15;i++){
      for(int j=0;j<15;j++){
        pushMatrix();
        fill(255,0,0);
        translate(i*45,j*45);
        rotateY(radians(i*10+frameCount));
        rotateZ(radians(i*10+frameCount));
        box(noise(i,j,tempo)*30);
        popMatrix();
      }
    }
  popMatrix();
  tempo+=0.01;
  stroke(0);
  fill(0);
  rect(320,40,200,200);
  
  hint(DISABLE_DEPTH_TEST);
  fill(255);
  rect(320,240,200,200);
}
