import processing.video.*;

Capture webcam;

int numPixels;
int threshold;

void setup()
{
    size( 640, 480 );
    smooth();
    
    webcam = new Capture( this, width, height);
    webcam.start();
    
    numPixels = webcam.width * webcam.height;
    threshold = 127;
}

void draw()
{
    if ( webcam.available() ) {
        webcam.read();
        image( webcam, 0, 0 );
        float b;
        
        loadPixels();
        for ( int i = 0; i < numPixels; i++ ) {
            b = brightness( webcam.pixels[i] );
            if ( b > threshold ) {
                pixels[i] = color( 255 );
            } else {
                pixels[i] = color( 0 );
            }
        }
        updatePixels();
    
    }
    
    fill( 255, 0, 0 );
    noStroke();
    rect( 10, 10, 110, 20 );
    fill( 255 );
    text( "Threshold: " + threshold, 14, 24 );
}

void keyPressed()
{
    if ( key == CODED ) {
        if ( keyCode == UP ) {
            threshold++;
            println( threshold );
        }
        if ( keyCode == DOWN ) {
            threshold--;
            println( threshold );
        }
    }
}
