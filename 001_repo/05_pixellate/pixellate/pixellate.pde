import processing.video.*;
Capture vid;
int s = 10;

void setup() {
  size(640, 480);
  vid = new Capture(this, width/s, height/s);
  vid.start();
} 


void draw() {
  if (vid.available()) {
    vid.read();
    //image(vid, 0, 0);
    for (int y=0; y<height/s; y++) {
      for (int x=0; x<width/s; x++) {
      color c = vid.pixels[y*vid.width+x]; 
      fill(c);
      //Also interesting... 
      //rect(x*s, y*s, s, s);
      text(x%2, x*s, y*s); 
      } 
    }
    
  }
}
