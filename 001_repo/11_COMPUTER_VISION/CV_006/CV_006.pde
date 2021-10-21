import processing.video.*;
int numPixels;
int[] backgroundPixels;
Capture video;
float threshold = 0.0;
PImage bg;

void setup() {
  size(640, 480); // Change size to 320 x 240 if too slow at 640 x 480 
  video = new Capture(this, width, height);
  video.start();
  numPixels = video.width * video.height;
  // Create array to store the background image
  backgroundPixels = new int[numPixels];
  // Make the pixels[] array available for direct manipulation
  loadPixels();
  backgroundPixels = pixels;
  bg = loadImage("bg.jpg");
}
void draw() {
  threshold = mouseX;
  if (video.available()) {
    video.read(); // Read a new video frame 
    video.loadPixels(); // Make the pixels of video available
    for (int i = 0; i < numPixels; i++) { 
      color pixel = video.pixels[i];
      color bgpixel = backgroundPixels[i];
      float distance = dist(red(pixel),green(pixel),blue(pixel),
        red(bgpixel),green(bgpixel),blue(bgpixel));
        if(distance<=threshold){
          pixels[i] = bg.pixels[i];
        }
        else{
          pixels[i] = pixel;
        }
    }
    updatePixels(); 
  } 
}

// When a key is pressed, capture the background image into the backgroundPixels 
// buffer by copying each of the current frame’s pixels into it.
void keyPressed() {
  video.loadPixels();
  arraycopy(video.pixels, backgroundPixels);
}
