
void setup() {
  size(600, 600, P3D);
  
}
void draw() {
  background(255);
  translate(width/2, height/2, -width);
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateX(map(mouseY, 0, height, -PI, PI));
  stroke(0);
  fill(200);
  rect(-200, -200, 400, 400);
  line(0, 0, -200, 0, 0, 200);
}
/*
float depth;
boolean directionZ;

void setup()
{
    size( 640, 480, P3D );
    
    depth = 0;
    directionZ = true;
}

void draw()
{
    if ( directionZ == true ) {
        depth--;
        if ( depth <= -900 ) {
            directionZ = false;
        }    
    } else {
        depth++;
        if ( depth >= 0 ) {
            directionZ = true;
        }
    }
    
    background( 255 );
    
    noFill();
    stroke( 0 );
    for ( int i = 0; i < 10; i++ ) {
        pushMatrix();
        translate( 0, 0, -i * 100 );
        rect( 0, 0, width, height );
        popMatrix();
    }

    pushMatrix();
    translate( 0, 0, depth );
    fill( 255, 0, 0 );
    rect( 0, 0, 80, 80 );
    fill( 0, 255, 0 );
    rect( width-80, 0, 80, 80 );
    fill( 255, 255, 0 );
    rect( width-80, height-80, 80, 80 );
    fill( 0, 255, 255 );
    rect( 0, height-80, 80, 80 );
    popMatrix();
}
*/
