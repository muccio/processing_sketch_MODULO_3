XML xml;

void setup(){
  xml = loadXML("processing-websites.xml");
}

void draw(){
  background(0);
}

void keyPressed(){
  println("lettura");
  XML[] valori=xml.getChildren("website");
  for(int i=0;i<valori.length;i++){
    int id = valori[i].getInt("id");
    String url = valori[i].getString("url");
    String txt = valori[i].getContent();
    println(i+" - "+id+" "+url+ " " +txt);
  }
}
