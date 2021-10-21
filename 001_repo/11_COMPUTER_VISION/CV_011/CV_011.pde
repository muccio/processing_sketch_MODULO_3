import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);

  video.start();
}

void draw() {
  opencv.loadImage(video);
  opencv.setROI(mouseX, mouseY, 100, 100);
  opencv.findCannyEdges(20,75);
  image(opencv.getOutput(), 0, 0);

}

void captureEvent(Capture c) {
  c.read();
}
