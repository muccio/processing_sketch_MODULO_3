class coordinatePolari {
  float angolo = 0.0;
  AudioIn in;
  FFT fft;
  float[] bins;
  Amplitude amp;
  float zoom = 100;
  PostFX fx;

  void setup(PApplet t) {
    in = new AudioIn(t, 0);
    in.start();
    fft = new FFT(t, 1024);
    fft.input(in);
    bins = new float[1024];
    amp = new Amplitude(t);
    amp.input(in);
    fx = new PostFX(t);
    textSize(80);
    textMode(SHAPE);
    textAlign(CENTER, CENTER);
  }

  float textz = -200;

  void draw() {
    hint(ENABLE_DEPTH_TEST);
    fft.analyze(bins);
    zoom = 100 + amp.analyze()*300;
    background(0);
    pushMatrix();
    translate(width/2, height/2, zoom);
    rotateX(angolo);
    rotateY(angolo);
    rotateZ(angolo);
    lights();
    noStroke();
    fill(0);
    sphere(100);
    disegnaRiccio(100, 128, color(0, 255, 0));
    angolo+=0.001;
    popMatrix();
    stroke(255);
    fill(255);
    text("TESTO", width/2, height/2, textz);
    textz++;
    if (textz>500)textz=-200;
    fx.render().bloom(0.5, 50, 40).compose();
  }

  void disegnaRiccio(int raggio, int tot, color c) {
    int counter = 0;
    for (int i=0; i<tot; i++) {
      float lon = map(i, 0, tot, -PI, PI);
      for (int j=0; j<tot; j++) {
        float moltiplicatore = bins[50+counter]*60;
        float raggio_dinamico = raggio + raggio*moltiplicatore;
        float lat = map(j, 0, tot, -HALF_PI, HALF_PI);
        float x = raggio_dinamico * sin(lon) * cos(lat);
        float y = raggio_dinamico * sin(lon) * sin(lat);
        float z = raggio_dinamico * cos(lon);
        //strokeWeight(3);
        stroke(0);
        beginShape(LINES);
        vertex(x, y, z);
        stroke(c, 150);
        vertex(x*1.20, y*1.20, z*1.20);
        vertex(x*1.20, y*1.20, z*1.20);
        stroke(c, 255);
        vertex(x*1.40, y*1.40, z*1.40);
        vertex(x*1.40, y*1.40, z*1.40);
        stroke(255, 255);
        vertex(x*1.45, y*1.45, z*1.45);
        endShape();
        //point(x,y,z);
        counter++;
        if (counter>512) {
          counter = 0;
        }
      }
    }
  }
}
