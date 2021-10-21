import themidibus.*; 

MidiBus myBus; 
float angolo = 0;

void setup() {
  size(400, 400);
  background(0);
  MidiBus.list(); 
  myBus = new MidiBus(this, 5, 2); 
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2,height/2);
  rotate(angolo);
  fill(255);
  rectMode(CENTER);
  rect(0,0,100,100);
  popMatrix();
}


void controllerChange(int channel, int number, int value) {
  angolo = map(value,0.0,127.0,0,2*PI);
}
