import processing.sound.*;

AudioIn in;
Amplitude amp;

void setup(){
  size(400,400,P3D);
  in = new AudioIn(this);
  in.start();
  amp = new Amplitude (this);
  amp.input(in);
}

void draw(){
  background(0);
  noStroke();
  fill(50);
  //imposta la componente speculare della luce
  lightSpecular(255,255,255);
  //luce direzionale
  directionalLight(100,100,100,0,-1,0);
  translate(width/2,height/2);
  float componente_riflessiva = 512.0*(amp.analyze());
  //imposta la componente speculare 
  //del materiale del solido che segue
  specular(componente_riflessiva,componente_riflessiva,componente_riflessiva);
  sphere(100);
  
}
