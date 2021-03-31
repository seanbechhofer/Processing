// Based on https://openprocessing.org/sketch/492680

// import the video capture library
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

int PLAINCIRCLE = 0;
int RINGEDCIRCLE = 1; 
int SPLITCIRCLE = 2;
int PLAINSQUARE = 3;
int RINGEDSQUARE = 4;
int SHAPES = 6;


int colourCount = colours.length;
float rotation = 0;
float rotationSpeed = 0.002;
float rotationAcceleration = 0.000005;

boolean spin = true;

int shapeSelect(int i) {
  return RINGEDCIRCLE;
  //return i%SHAPES;
}

void setup() {

  for (int i = 0; i<p.length; i++) {
    p[i] = new Particle(i%colourCount, shapeSelect(i));
    p[i].o = random(1, random(1, width/p[i].n));
  }
  fullScreen(1);
  //size(1280, 720);
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

  pushMatrix();
      
  for (int i = 0; i<p.length; i++) {
    p[i].draw();
    if (p[i].drawDist()>diagonal) {
      p[i] = new Particle(i%colourCount, shapeSelect(i));
    }
  }
  
  popMatrix();
  
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
    shape = s_;
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
    //fill(col, min(l, 255));
    if (shape == PLAINCIRCLE) {
      // Circle, single color
      ellipse(0, 0, width/o/planetSize, width/o/planetSize);
    } else if (shape == RINGEDCIRCLE) {  
      // Ringed Circle
      ringedCircle(l, o, planetSize, col);
    } else if (shape == SPLITCIRCLE) {  
      // Circle, two colours in halves, rotating. 
      rotate(rotation);
      rotation += spin;
      splitCircle(l, o, planetSize, col);
    } else if (shape == PLAINSQUARE) {
     // Rotating plain square
      rotate(rotation);
      rotation += spin;
      float edge = width/o/8;
      plainSquare(l,edge,col);
    } else if (shape == RINGEDSQUARE) {
       // Rotating ringed square
      rotate(rotation);
      rotation += spin;
      float edge = width/o/8;
      ringedSquare(l, edge, col);       
    } 
    popMatrix();

    o-=0.07;
  }
  float drawDist() {
    return atan(n/o)*width/HALF_PI;
  }
}
