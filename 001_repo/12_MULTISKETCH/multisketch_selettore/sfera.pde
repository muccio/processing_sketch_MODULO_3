class sketch_sfera {
  FFT fft;
  AudioIn in;
  float[] bins;
  Amplitude amp;
  PostFX fx;

  boolean start_fadeout = false;
  float fadeout_alpha = 255;
  void setup(PApplet cl) {
    
    in = new AudioIn(cl, 0);
    in.start();
    fft = new FFT(cl, 1024);
    fft.input(in);
    amp = new Amplitude(cl);
    amp.input(in);
    bins = new float[1024];
    fx = new PostFX(cl);
    textSize(80);
    textMode(SHAPE);
    textAlign(CENTER, CENTER);
  }

  float angle = 0.0;
  float zoom = 300;
  float textz = 250;

  void draw() {
    hint(ENABLE_DEPTH_TEST);
    background(0);
    translate(width/2, height/2, zoom);
    rotateX(angle);
    rotateY(angle);
    rotateZ(angle);
    fill(255);
    lights();
    fft.analyze(bins);
    fill(0);
    noStroke();
    sphere(100);
    dosfera(100, 128, color(#9ffffc, 125));
    fx.render().bloom(0.5, 50, 40).compose();
    angle += 0.001;
    zoom = 300 + amp.analyze()*300;
    fill(255);
    text("FRAME", width/2, height/2, textz);
    textz++;
    textz=textz<700?textz:250;
    fadeout(fadeout_alpha);
    if (start_fadeout) {
      if (fadeout_alpha<255)
        fadeout_alpha++;
    } else {
      if (fadeout_alpha>0)
        fadeout_alpha--;
    }
  }

  void dosfera(int r, int tot, color c) {
    int counter = 0;
    for (int i=0; i<tot; i++) {
      float lon = map(i, 0, tot, -PI, PI);
      for (int j=0; j<tot; j++) {
        float mult = bins[50+counter]*60;
        float dinr = r + r * mult;
        float lat = map(j, 0, tot, -HALF_PI, HALF_PI);
        float x = dinr * sin(lon) * cos(lat);
        float y = dinr * sin(lon) * sin(lat);
        float z = dinr * cos(lon);
        stroke(c, 100+155*mult);
        beginShape(LINES);
        stroke(0);
        vertex(x, y, z);
        stroke(c, 150);
        vertex( x*1.20, y*1.20, z*1.20);
        vertex( x*1.20, y*1.20, z*1.20);
        stroke(c, 255);
        vertex( x*1.40, y*1.40, z*1.40);
        vertex( x*1.40, y*1.40, z*1.40);
        stroke(255, 255);
        vertex( x*1.45, y*1.45, z*1.45);
        endShape();
        counter++;
        if (counter>512)
          counter=0;
      }
    }
  }

  void fadeout(float alpha) {
    fill(0, alpha);
    hint(DISABLE_DEPTH_TEST);
    rect(0, 0, width, height);
  }

  void keyPressed() {
    if (key== 'o') {
      start_fadeout = true;
    }
    if (key== 'i') {
      start_fadeout = false;
    }
  }
  
  void destroy(){
  }
}
