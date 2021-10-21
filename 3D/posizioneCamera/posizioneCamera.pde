void setup(){
  size(400,400,P3D);
}

void draw(){
  background(0);
  camera(30,200,220,
  0,0,0,
  0,1,0);
  lights();
  noStroke();
  box(90);
  stroke(255);
  line(-100,0,0,100,0,0);
  line(0,-100,0,0,100,0);
  line(0,0,-100,0,0,100);
}
