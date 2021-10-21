class sketch_rete_pallette {
  FFT fft;
  PImage img;
  //Timer timer;
  float[] bins;

  boolean start_fadeout = false;
  float fadeout_alpha = 255;
  Amplitude amp;
  AudioIn in;

  ArrayList insieme_pallette = new ArrayList(5);
  PostFX effetto;


  void setup(PApplet cl) {
    smooth();
    effetto = new PostFX(cl);

    in = new AudioIn(cl, 0);
    in.start();
    fft = new FFT(cl, 256);
    fft.input(in);
    amp = new Amplitude(cl);
    amp.input(in);

    //img = loadImage("covid.jpg");
    bins = new float[256];

    insieme_pallette.clear();
  }

  void draw() {
    //println("sketch_rete_pallette.draw()");
    background(0);
    fft.analyze(bins);
    if (insieme_pallette.size()>0) {
      for ( int i = 0; i < insieme_pallette.size(); i++ ) {
        palletta p = (palletta)insieme_pallette.get(i);
        p.display();
        p.update();
        p.checkDistanza(insieme_pallette);

        float r = bins[i]*600;
        float b = amp.analyze()*500;

        p.update(r, b);
      }
      //loadPixels();
      //img.mask(pixels);
      //image(img, 0, 0);
    }
    effetto.render().bloom(0.5, 50, 40).compose();
    //fill(255);
    //textSize(20);
    //text("-> "+insieme_pallette.size(), 20, 30);

    
  }

  void mousePressed() {
    for (int i=0; i<insieme_pallette.size(); i++) {
      palletta p = (palletta)insieme_pallette.get(i);
      p.impulso(mouseX, mouseY);
    }
  }

  void addPallette() {
    for (int i=0; i<256; i++) {
      float dimensione = 10.0;//random(5.0,10.0);
      int posizione_x = int(random(width));
      int posizione_y = int(random(height));
      insieme_pallette.add( new palletta(posizione_x, posizione_y, dimensione) );
    }
  }

  void keyPressed() {
    if (keyCode==ALT) {
      addPallette();
    }

    
  }

}
