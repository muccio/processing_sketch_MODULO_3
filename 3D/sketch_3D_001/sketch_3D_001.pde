/*
void setup(){
  size(600,600,P3D);
}

void draw(){
  background(255);
  translate(width/2,height/2,-width);
  float angoloX=map(mouseX,0,width,-PI,PI);
  float angoloY=map(mouseY,0,height,-PI,PI);
  rotateX(angoloX);
  rotateY(angoloY);
  
  stroke(0);
  fill(200);
  rect(-200,-200,400,400);
  line(0,0,-200,0,0,200);
}
*/

float profondita = 0;

void setup(){
  size(640,480,P3D);
}

void draw(){
  background(255);
  noFill();
  stroke(0);
  for(int i=0;i<10;i++){
    pushMatrix();
    translate(width/2,height/2,-i*100);
    rect(-width/2,-height/2,width,height);
    popMatrix();
  }
  pushMatrix();
  translate(width/2,height/2,profondita);
  fill(255,0,0);
  rect(-width/2,-height/2,80,80);
  fill(0,255,0);
  rect(width/2-80,-height/2,80,80);
  fill(255,255,0);
  rect(width/2-80,height/2-80,80,80);
  fill(0,255,255);
  rect(-width/2,height/2-80,80,80);
  popMatrix();
  profondita--;
}
