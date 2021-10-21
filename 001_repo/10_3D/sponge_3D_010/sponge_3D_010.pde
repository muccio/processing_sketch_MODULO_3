class Box{
  int x,y,z,r;
  
  Box(int x_,int y_,int z_,int r_){
    x=x_;
    y=y_;
    z=z_;
    r=r_;
  }
  
  void draw(){
    pushMatrix();
    translate(x,y,z);
    box(r);
    popMatrix();
    
  }
  
  ArrayList<Box> generate(){
    ArrayList<Box> boxes = new ArrayList<Box>();
    for(int cx=-1;cx<2;cx++){
      for(int cy=-1;cy<2;cy++){
        for(int cz=-1;cz<2;cz++){
          int smallsize=r/3;
          Box small = new Box(x+cx*smallsize,y+cy*smallsize, z+cz*smallsize,smallsize);
          if(abs(cx)+abs(cy)+abs(cz)>1)
             boxes.add(small);
        }
      }
    }
    return boxes;
  }
}

float angle = 0.0;
Box b;
ArrayList<Box> sponge;

void setup(){
  size(800,800,P3D);
  sponge = new ArrayList<Box>();
  b=new Box(0,0,0,400);
  sponge.add(b);
}

void draw(){
  background(0);
  stroke(255);
  //noFill();
  fill(255);
  lights();
  
  translate(width/2,height/2);
  rotateX(angle);
  rotateY(angle*0.2);
  rotateZ(angle*0.3);
  for(Box b : sponge)
     b.draw();
  angle+=0.01; 
}

void mousePressed(){
  ArrayList<Box>nextgen = new ArrayList<Box>();
  for(Box b:sponge){
    nextgen.addAll(b.generate());
  }
  sponge = nextgen;
  
}
