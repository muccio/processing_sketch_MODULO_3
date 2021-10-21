import processing.video.*;

Movie m;
PGraphics sliced;
int slices=4;
float alpha = 0.0;

void setup(){
  size(960,540,P2D);
  m = new Movie( this, "home.mov" );
  m.loop();
  sliced = createGraphics(960,540,P2D);
}

void draw(){
  //image(m,0,0);
  sliced.beginDraw();
  
  int x = width/slices;
  for(int i=0;i<slices;i++){
    int sy = i%2==0?i*int(abs(sin(alpha)*50)):i*int(abs(cos(alpha)*50));
    sliced.copy(m,i*x, sy, x, height, i*x, 0, x, height);
    fill(255);
    sliced.line(i*x, 0, i*x, height);
  }
  sliced.endDraw();
  image(sliced,0,0);
  alpha += 0.01;
}

void movieEvent( Movie m ){
    m.read();
}

void mouseMoved(){
  slices = 1+mouseX/50;
}

void keyPressed(){
  saveFrame("fr.jpg");
}
