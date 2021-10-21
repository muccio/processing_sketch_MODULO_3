import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import javax.swing.*;


import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
FFT fft;

PImage img;

Timer timer;

ArrayList insieme_pallette = new ArrayList(5);
PostFX effetto;

void setup(){
  size(1280,960,P3D);
  smooth();
  effetto = new PostFX(this);
  minim = new Minim(this);
  player = minim.loadFile("prova.mp3",512);
  player.loop();
  fft = new FFT(player.bufferSize(),player.sampleRate());
  setTimeout("initInsieme",1000);
  img = loadImage("covid.jpg");
}


void initInsieme(){
  for(int i=0;i<fft.specSize();i++){
    float dimensione = 10.0;//random(5.0,10.0);
    int posizione_x = int(random(width));
    int posizione_y = int(random(height));
    insieme_pallette.add(i,new palletta(posizione_x,posizione_y,dimensione));
  }
}

void draw(){
  background(0);
  fft.forward(player.mix);
  for(int i=0;i<insieme_pallette.size();i++){
    palletta p = (palletta)insieme_pallette.get(i);
    p.display();
    p.update();
    p.checkDistanza(insieme_pallette);
  }
  if(fft.specSize()>0&&insieme_pallette.size()>0){
    for ( int i = 0; i < fft.specSize() - 1; i++ ) {
        palletta p = (palletta)insieme_pallette.get(i);
        float r = fft.getBand(i)*3;
        float b = player.mix.get(i*2);
        p.update(r,b);
    }
    loadPixels();
    img.mask(pixels); //<>//
    image(img,0,0);
  }
  effetto.render().bloom(0.5,50,40).compose();
  fill(255);
  textSize(20);
  text("-> "+insieme_pallette.size(),20,30);
}

void mousePressed(){
  for(int i=0;i<insieme_pallette.size();i++){
    palletta p = (palletta)insieme_pallette.get(i);
    p.impulso(mouseX,mouseY);
  }
}

void keyPressed(){
  if(keyCode==ALT){
    for(int i=0;i<10;i++){
      float dimensione = 10.0;//random(5.0,10.0);
      int posizione_x = int(random(width));
      int posizione_y = int(random(height));
      insieme_pallette.add( new palletta(posizione_x,posizione_y,dimensione) );
    }
  }
}
