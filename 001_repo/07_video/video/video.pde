/*
//BASIC
import processing.video.*;
Movie m;

void setup(){
    size( 640, 480 );
    m = new Movie( this, "marbles.mov" );
    m.loop();
}

void draw(){
    background( 0 );
    image( m, 0, 0, width, height );
}

void movieEvent( Movie m ){
    m.read();
}
*/
/*
//MANIPOLAZIONE PIXEL
import processing.video.*;

Movie m;

void setup(){
    size( 640, 480 );
    m = new Movie( this, "marbles.mov" );
    m.loop();
}

void draw(){
    background( 0 );
    image( m, 0, 0, width, height );
    int numPixels = width * height;
    loadPixels();
    for ( int i = 0; i < numPixels; i++ ) {
        float b = brightness( pixels[i] );
        if ( b > 245 ) {
            pixels[i] = lerpColor( pixels[i], color( 0, 0, 0 ), map( b, 0, 255, 0, 1 ) );
        }
    }
    updatePixels();
}

void movieEvent( Movie m ){
    m.read();
}
*/
/*
//FILTRI
import processing.video.*;
Movie m;

void setup(){
    size( 640, 480 );
    m = new Movie( this, "marbles.mov" );
    m.loop();
}

void draw(){
    background( 0 );
    image( m, 0, 0, width, height );
    filter( POSTERIZE, 4 );
}

void movieEvent( Movie m ){
    m.read();
}
*/
/*
//VELOCITA
import processing.video.*;
Movie m;
float s;

void setup(){
    size( 640, 480 );
    m = new Movie( this, "marbles.mov" );
    m.loop();   
    s = 1.0;
}

void draw(){
    background( 0 );
    image( m, 0, 0, width, height );  
    fill( 0 );
    text( "Speed: " + s, 20, 20 ); 

}

void movieEvent( Movie m ){
    m.read();
}

void mousePressed(){
    s = map( mouseX, 0, width, -2, 2 );
    m.speed( s ); 
}
*/
/*
//POSIZIONE
  
import processing.video.*;
Movie myMovie;

void setup() {
  size(640, 480);
  frameRate(30);
  myMovie = new Movie(this, "marbles.mov");
  myMovie.loop();
}

void draw() {
  if (myMovie.available()) {
    myMovie.read();
  }
  image(myMovie, 0, 0);
}

void mousePressed() {
  myMovie.jump(random(myMovie.duration()));
}
*/

//BLENDING
import processing.video.*;

Movie m1;
Movie m2;

void setup(){
    size( 640, 480 );
    m1 = new Movie( this, "marbles.mov" );
    m1.loop();
    m2 = new Movie( this, "marbles2.mov" );
    m2.loop();
    m2.speed( 2 );
}

void draw(){
    background( 0 );
    image( m1, 0, 0, width, height );
    blend( m2, 0, 0, width, height, 0, 0, width, height, DIFFERENCE);
}

void movieEvent( Movie m ){
    if ( m == m1 ) {
        m1.read();
    } else {
        m2.read();
    }
}
