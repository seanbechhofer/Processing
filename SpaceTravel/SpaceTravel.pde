// Based on https://openprocessing.org/sketch/492680

// import the library
import com.hamoid.*;

// create a new VideoExport-object
VideoExport videoExport;

Particle[] p = new Particle[800];
int diagonal;

//int[] colours = {#884400,#008844,#440088,#448800,#004488,#880044};
int[] colours = {
  #888888 
  ,#663300, #006633, #330066, #336600, #003366, #660033 
//  ,#884400, #008844, #440088, #448800, #004488, #880044 
//  ,#993300, #009933, #330099, #339900, #003399, #990033 
//  ,#aa2200, #00aa22, #2200aa, #22aa00, #0022aa, #aa0022
};

int planetSize = 4;

int colourCount = colours.length;
float rotation = 0;
float rotationSpeed = 0.002;
float rotationAcceleration = 0.000005;

boolean spin = true;

void setup() {

  for (int i = 0; i<p.length; i++) {
    p[i] = new Particle(i%colourCount, i%2);
    p[i].o = random(1, random(1, width/p[i].n));
  }
  //fullScreen(1);
  size(1280, 720);
  //size(640, 360);
  diagonal = (int)sqrt(width*width + height * height)/2;
  background(50);
  noStroke();
  fill(255);
  frameRate(30);
  
  videoExport = new VideoExport(this, "myVideo.mp4");
  videoExport.setFrameRate(30);  
  videoExport.startMovie();
}

void draw() {
  if (!mousePressed) {
    background(0);
  }

  translate(width/2, height/2);
 
  if (spin) {
    rotationSpeed += rotationAcceleration;
    if ((rotationSpeed > 0.005) || (rotationSpeed < -0.005)) {
      println("Flip");
      rotationAcceleration = -rotationAcceleration;
    }
  }
  rotation+=rotationSpeed;
  rotate(rotation);

  for (int i = 0; i<p.length; i++) {
    p[i].draw();
    if (p[i].drawDist()>diagonal) {
      p[i] = new Particle(i%colourCount, i%2);
    }
  }
  
  videoExport.saveFrame();
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}  

class Particle {
  float n;
  float r;
  float o;
  int colour;
  int shape;
  float rotation;
  float spin;
  float delta;
  int l;

  Particle(int c_, int s_) {
    l = 1;
    colour = c_;
    shape = 1;
    rotation = random(0, TWO_PI);
    spin = random(-0.1,0.1);
    n = random(1, width/2);
    r = random(0, TWO_PI);
    o = random(1, random(1, width/n));
  }

  void draw() {
    l++;
    pushMatrix();
    rotate(r);
    translate(drawDist(), 0);        

    //scale((width/o)/32);
    //tint(colours[c], min(l, 255));
    //image(img, 0, 0);
    scale(1);
    int col = colours[colour];
    fill(col, min(l, 255));
    if (shape == 0) {
      // Circle, single color
      //ellipse(0, 0, width/o/planetSize, width/o/planetSize);
      
      // Circle, two colours 
      
      ellipse(0, 0, width/o/planetSize, width/o/planetSize);
      int alt = lerpColor(col,#000000,0.5);
      fill(alt, min(l, 255));
      ellipse(0, 0, 0.75*width/o/planetSize, 0.75*width/o/planetSize);
      alt = lerpColor(col,#000000,0.25);
      fill(alt, min(l, 255));
      ellipse(0, 0, 0.5*width/o/planetSize, 0.5*width/o/planetSize);
      
      // Circle, two colours, rotating. 
      //rotate(rotation);
      //rotation += spin;
      
      //arc(0, 0, width/o/planetSize, width/o/planetSize,0,PI);
      //int opposite = lerpColor(col,#ffffff,0.5);
      //fill(opposite, min(l, 255));
      //arc(0, 0, width/o/planetSize, width/o/planetSize,PI,TWO_PI);
      
    } else {
      rotate(rotation);
      rotation += spin;
      float edge = width/o/8;
      beginShape();      
      vertex(edge, edge);
      vertex(-edge, edge);
      vertex(-edge, -edge);
      vertex(edge, -edge);
      endShape(CLOSE);
      
      int alt = lerpColor(col,#000000,0.5);
      fill(alt, min(l, 255));
      edge = edge * 0.75;
      beginShape();      
      vertex(edge, edge);
      vertex(-edge, edge);
      vertex(-edge, -edge);
      vertex(edge, -edge);
      endShape(CLOSE);
      alt = lerpColor(col,#000000,0.25);
      fill(alt, min(l, 255));
      edge = edge * 0.5;
      beginShape();      
      vertex(edge, edge);
      vertex(-edge, edge);
      vertex(-edge, -edge);
      vertex(edge, -edge);
      endShape(CLOSE);
      //square(0, 0, width/o/12);
    }
    //fill(colours[(c+2)%colourCount], min(l, 255));
    //ellipse(0, 0, width/o/16, width/o/4);
    popMatrix();

    o-=0.07;
  }
  float drawDist() {
    return atan(n/o)*width/HALF_PI;
  }
}
