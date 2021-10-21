
import processing.pdf.*;
import java.util.Calendar;
import processing.video.*;
Capture cam;

boolean savePDF = false;

String inputText = "Sempre caro mi fu quest'ermo colle,E questa siepe, che da tanta parteDell'ultimo orizzonte il guardo esclude.Ma sedendo e mirando, interminatiSpazi di là da quella, e sovrumaniSilenzi, e profondissima quieteIo nel pensier mi fingo; ove per pocoIl cor non si spaura. E come il ventoOdo stormir tra queste piante, io quelloInfinito silenzio a questa voceVo comparando: e mi sovvien l'eterno,E le morte stagioni, e la presenteE viva, e il suon di lei. Così tra questa Immensità s'annega il pensier mio:E il naufragar m'è dolce in questo mare.";
float fontSizeMax = 20;
float fontSizeMin = 4;
float spacing = 8; // line height
float kerning = 1; // between letters

boolean fontSizeStatic = false;
boolean blackAndWhite = false;

PFont font;
PImage img;

void setup() {
  size(640,480);
  smooth(); 
  
  font = createFont("Times",10);
  
  //img = loadImage("pic.png");
  //println(img.width+" x "+img.height);
  
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i+" "+cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
    img = createImage(640, 360, ARGB);
  }      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    //image(cam, 0, 0, width, height);
    img.copy(cam, 0, 0, cam.width, cam.height, 0, 0, img.width, img.height);
    image(img, width/2 - 640/2, height/2 - 360);
  }
  else{
    return;
  }
  
  
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");

  background(255);
  textAlign(LEFT);
  //textAlign(LEFT,CENTER); //// also nice!

  float x = 0, y = 10;
  int counter = 0;
int punti_campionati=0;
  while (y < height) {
    // translate position (display) to position (image)
    int imgX = (int) map(x, 0,width, 0,img.width);
    int imgY = (int) map(y, 0,height, 0,img.height);
    // get current color
    color c = img.pixels[imgY*img.width+imgX];
    int greyscale = round(red(c)*0.222 + green(c)*0.707 + blue(c)*0.071);

    pushMatrix();
    translate(x, y);

    if (fontSizeStatic) {
      textFont(font, fontSizeMax);
      if (blackAndWhite) fill(greyscale);
      else fill(c);
    } 
    else {
      // greyscale to fontsize
      float fontSize = map(greyscale, 0,255, fontSizeMax,fontSizeMin);
      fontSize = max(fontSize, 1);
      textFont(font, fontSize);
      if (blackAndWhite) fill(0);
      else fill(c);
    } 

    char letter = inputText.charAt(counter);
    text(letter, 0, 0);
    float letterWidth = textWidth(letter) + kerning;
    // for the next letter ... x + letter width
    x = x + letterWidth; // update x-coordinate
    popMatrix();

    // linebreaks
    if (x+letterWidth >= width) {
      x = 0;
      y = y + spacing; // add line height
    }

    counter++;
    if (counter > inputText.length()-1) counter = 0;
    
    punti_campionati++;
  }

println("punti_campionati "+punti_campionati);
  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}


void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;
  // change render mode
  if (key == '1') fontSizeStatic = !fontSizeStatic;
  // change color stlye
  if (key == '2') blackAndWhite = !blackAndWhite;
  println("fontSizeMin: "+fontSizeMin+"  fontSizeMax: "+fontSizeMax+"   fontSizeStatic: "+fontSizeStatic+"   blackAndWhite: "+blackAndWhite);
}

void keyPressed() {
  // change fontSizeMax with arrowkeys up/down 
  if (keyCode == UP) fontSizeMax += 2;
  if (keyCode == DOWN) fontSizeMax -= 2; 
  // change fontSizeMin with arrowkeys left/right
  if (keyCode == RIGHT) fontSizeMin += 2;
  if (keyCode == LEFT) fontSizeMin -= 2; 

  //fontSizeMin = max(fontSizeMin, 2);
  //fontSizeMax = max(fontSizeMax, 2);
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
