import processing.video.*;
color black = color(0);
color white = color(255);
int numPixels;
Capture video;

void setup() {
  size(640, 480); // Change size to 320 x 240 if too slow at 640 x 480 
  strokeWeight(5);
  video = new Capture(this, width, height);
  video.start();
  numPixels = video.width * video.height;
  noCursor();
  smooth();
}
void draw() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    int threshold = 127;
    float pixelBrightness; // Declare variable to store a pixel's color
    // Turn each pixel in the video frame black or white depending on its brightness
    loadPixels();
    for (int i = 0; i < numPixels; i++) {
      pixelBrightness = brightness(video.pixels[i]);
      if (pixelBrightness > threshold) { // If the pixel is brighter than the
        pixels[i] = white;
      } else {
        pixels[i] = black;
      } 
    }
    updatePixels();
    // threshold value, make it white
    // Otherwise,
    // make it black
    // Set the threshold value
    // Test a location to see where it is contained. Fetch the pixel at the test 
    // location (the cursor), and compute its brightness
    int testValue = get(mouseX, mouseY);
    float testBrightness = brightness(testValue);
    if (testBrightness > threshold) {
      fill(black);
    } else {
      fill(white);
    }
    ellipse(mouseX, mouseY, 20, 20);
  }
}
