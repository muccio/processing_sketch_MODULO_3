class palletta {
  float x, y;
  float vx, vy;
  float size;
  float r=255, g=255, b=255;

  float ax=0.0, ay=0.0;

  palletta(int posizione_x, int posizione_y, float dimensione) {
    x = posizione_x;
    y = posizione_y;
    size = dimensione;
    vx = random(-2.2, 2.2);
    vy = random(-2.2, 2.2);
  }

  void display() {
    stroke(r, g, b);
    fill(r, g, b);
    ellipse(x, y, size, size);
    stroke(255);
    fill(255);
    //textSize(8);
    //String testo_da_scrivere = int(x) + "-" + int(y);
    //text(testo_da_scrivere, x+size, y+size);
  }

  void update(float _r, float _b) {
    size = _r;
    size = constrain(size, 10, 100);
    if (size>10) {
      g = map(_b, -1, 1, 0, 255);
      b = g;
    } else
      g = 255;
    b = g;
  }

  void update() {
    x += vx;
    y += vy;

    if (x>width || x<0) {
      vx = -vx;
    }
    if (y>height || y<0) {
      vy = -vy;
    }

    x+=ax;
    y+=ay;

    if (ax>0) {
      ax-=0.1;
    } else {
      ax=0;
    }
    if (ay>0) {
      ay-=0.1;
    } else {
      ay=0;
    }

    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }

  void checkDistanza(ArrayList parametro_array) {

    for (int i=0; i<parametro_array.size(); i++) {
      palletta p = (palletta)(parametro_array.get(i));
      float distanza = dist(x, y, p.x, p.y);
      if (distanza<100) {
        stroke(255);
        line(x, y, p.x, p.y);
      }
    }
  }

  void impulso(float px, float py) {
    float dx = x - px;
    float dy = y - py;
    PVector a = new PVector(-dx, -dy);
    a.normalize();
    ax = a.x * 10.0;
    ay = a.y * 10.0;
  }
}
