class videoSlices {

  Movie m;
  PGraphics buffer_in_memoria;
  int numero_fettine = 10;
  float angolo = 0.0;
  float moltiplicatore_seno = 50.0;

  //modificare i setup in modo che ountino al master sketch
  //quando viene utilizzato this
  void setup(PApplet p) {
    //size(960, 540, P2D);
    m = new Movie(p, "home.mov");
    m.loop();
    //DEFINIZIONE BUFFER IN MEMORIA
    buffer_in_memoria = createGraphics(960, 540, P3D);
  }

  void draw() {
    //image(m,0,0);
    
    //CALCOLO LARGHEZZA FETTINA
    int larghezza_fettina = width/numero_fettine;
    //DISEGNO SUL BUFFER
    buffer_in_memoria.beginDraw();
    for (int i=0; i<numero_fettine; i++) {
      //CALCOLO DELLA COORDINATA Y DELLA FETTINA i
      int coordinata_y;
      if (i%2==0) {//SE i E' NUMERO PARI
        coordinata_y = int(abs(sin(angolo)*moltiplicatore_seno));
        //VALORE ASSOLUTO DEL SENO
      } else {
        coordinata_y = int(abs(cos(angolo)*moltiplicatore_seno));
        //VALORE ASSOLUTO DEL COSENO
      }
      buffer_in_memoria.copy(m,  //<>//
        i*larghezza_fettina, coordinata_y, larghezza_fettina, height, //AREA SORGENTE
        i*larghezza_fettina, 0, larghezza_fettina, height//AREA DESTINAZIONE
        );
      buffer_in_memoria.line(i*larghezza_fettina, 0, i*larghezza_fettina, height);
    }
    buffer_in_memoria.endDraw();
    image(buffer_in_memoria, 0, 0);
    angolo += 0.01;
    filter(POSTERIZE, 40);
    
  }

  //CALLBACK RICHIMATA OGNI VOLTA CHE E' DISPONIBILE UN FRAME DEL VIDEO 
  void movieEvent(Movie pippo) {
    if (pippo==m)
      pippo.read();
  }

  void mouseMoved() {
    numero_fettine = 1+ mouseX/20;
    moltiplicatore_seno = mouseY;
  }
}
