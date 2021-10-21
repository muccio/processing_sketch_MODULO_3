String lineeTesto[];

void setup(){
  lineeTesto = loadStrings("esempio.csv");
  println(lineeTesto.length);
}

void draw(){
  background(0);
}

void keyPressed(){
  println("lettura");
  for(int i=0;i<lineeTesto.length;i++){
    //println(lineeTesto[i]);
    String[] elementi = split(lineeTesto[i],";"); 
    for(int j=0;j<elementi.length;j++){
      println(elementi[j]);
    }
    println("---------");
  }
}
