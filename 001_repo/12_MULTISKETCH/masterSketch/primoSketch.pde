class primoSketch {

  void setup() {
    
  }

  float alpha = 0.0;

  void draw() {

    translate(width/2, height/2);
    pushMatrix();
    rotate(alpha);
    background(0);
    rectMode(CENTER);
    fill(255);
    rect(0, 0, 100, 100);
    popMatrix();
    alpha += 0.01;
  }
}
