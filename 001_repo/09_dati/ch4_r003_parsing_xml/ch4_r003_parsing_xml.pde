XML xml;

void setup()
{
    xml = loadXML( "processing-websites.xml" );
    noLoop();
}

void draw()
{
    XML[] kids = xml.getChildren("website");
    
    for ( int i = 0; i < kids.length; i++ ) {
        int id = kids[i].getInt("id");
        String url = kids[i].getString("url");
        String txt = kids[i].getContent();
        println( i + ": " + id + " " + url + " " + txt );
    }
}
