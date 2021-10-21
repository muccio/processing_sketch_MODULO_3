float angoloY = 0.0;
int modalita_illuminazione = 0;
color colore_luce =  color(255,255,0);
PVector direzione_luce = new PVector(0,0,0);

void setup(){
  size(400,400,P3D);
}

void draw(){
  background(0);
  switch(modalita_illuminazione){
    case 0:
      noLights();
    break;
    case 1:
      lights();
    break;
    case 2://directionalLight
    println("directionalLight");
      directionalLight(
        red(colore_luce),
        green(colore_luce),
        blue(colore_luce),
        direzione_luce.x,
        direzione_luce.y,
        direzione_luce.z
        );
      break;
    case 3://ambientLight
      ambientLight(red(colore_luce),
        green(colore_luce),
        blue(colore_luce));
      break;
    case 4://pointLight
      pointLight(red(colore_luce),
        green(colore_luce),
        blue(colore_luce),
        100,height/3,100
        );
      break;
    case 5://spotLight
      spotLight(red(colore_luce),
        green(colore_luce),
        blue(colore_luce),
        mouseX,mouseY,100,
        0,
        0,
        -1,
        radians(120),600
        );
      break;
  }
  noStroke();
  //stroke(0,0,255);
  translate(width/2,100,-500);
  rotateY(angoloY);
  pushMatrix();
  translate(-200,0,0);
  fill(0,255,0);
  box(200,200,200);
  popMatrix();
  pushMatrix();
  translate(200,0,0);
  fill(255,0,0);
  sphereDetail(5);
  sphere(150);
  popMatrix();
  pushMatrix();
  translate(-200,300,0);
  fill(255,255,0);
  sphereDetail(10);
  sphere(150);
  popMatrix();
  
  angoloY+=0.01;
}

void keyPressed(){
  switch(key){
    case '1'://lights
      modalita_illuminazione = 1;
      break;
    case '2'://directionalLight
      modalita_illuminazione = 2;
      break;
    case '3'://ambientLight
      modalita_illuminazione = 3;
      break;
    case '4'://pointLight
      modalita_illuminazione = 4;
      break;
    case '5'://spotLight
      modalita_illuminazione = 5;
      break;
    default://nessuna illuminazione
      modalita_illuminazione = 0;
      break;
  }
  switch(keyCode){
    case UP:
      direzione_luce = new PVector(0,-1,0);
    break;
    case DOWN:
      direzione_luce = new PVector(0,1,0);
    break;
    case LEFT:
      direzione_luce = new PVector(-1,0,0);
    break;
    case RIGHT:
      direzione_luce = new PVector(1,0,0);
    break;
  }
  
  println("modalita_illuminazione: "+modalita_illuminazione);
  println("direzione_luce: "+direzione_luce);
}
