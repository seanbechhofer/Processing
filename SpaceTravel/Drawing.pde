 void ringedCircle(int l, float o, int size, int colour) {
    // Circle, two colours 
      fill(colour, min(l, 255));
      ellipse(0, 0, width/o/size, width/o/size);
      int alt = lerpColor(colour,#000000,0.75);
      fill(alt, min(l, 255));
      ellipse(0, 0, 0.75*width/o/size, 0.75*width/o/size);
      alt = lerpColor(colour,#000000,0.5);
      fill(alt, min(l, 255));
      ellipse(0, 0, 0.5*width/o/size, 0.5*width/o/size);      
      alt = lerpColor(colour,#000000,0.25);
      fill(alt, min(l, 255));
      ellipse(0, 0, 0.25*width/o/size, 0.25*width/o/size);      
  }
  
  void splitCircle(int l, float o, int size, int colour) {
    // Circle, two colours 
      fill(colour, min(l, 255));
      arc(0, 0, width/o/size, width/o/size,0,PI);
      int opposite = lerpColor(colour,#ffffff,0.5);
      fill(opposite, min(l, 255));
      arc(0, 0, width/o/size, width/o/size,PI,TWO_PI);      
  }
  
  void plainSquare(int l, float size, int colour) {
    float edge = size;
    fill(colour, min(l, 255));
    beginShape();      
    vertex(edge, edge);
    vertex(-edge, edge);
    vertex(-edge, -edge);
    vertex(edge, -edge);
    endShape(CLOSE);
  } 
  
  void randomShape(int l, float size, int colour) {
    float edge = size;
    fill(colour, min(l, 255));
    beginShape();
    for (int v = 0; v < 7; v++){    
      vertex(edge * random(-1,1), edge * random (1,-1));
    }
    endShape(CLOSE);
  }
  
  void ringedSquare(int l, float size, int colour) {
    float edge = size;
    fill(colour, min(l, 255));
    beginShape();      
    vertex(edge, edge);
    vertex(-edge, edge);
    vertex(-edge, -edge);
    vertex(edge, -edge);
    endShape(CLOSE);
      
    int alt = lerpColor(colour,#000000,0.75);
    fill(alt, min(l, 255));
    edge = size * 0.75;
    beginShape();      
    vertex(edge, edge);
    vertex(-edge, edge);
    vertex(-edge, -edge);
    vertex(edge, -edge);
    endShape(CLOSE);
    
    alt = lerpColor(colour,#000000,0.5);
    fill(alt, min(l, 255));
    edge = size * 0.5;
    beginShape();      
    vertex(edge, edge);
    vertex(-edge, edge);
    vertex(-edge, -edge);
    vertex(edge, -edge);
    endShape(CLOSE);
    
    alt = lerpColor(colour,#000000,0.25);
    fill(alt, min(l, 255));
    edge = size * 0.25;
    beginShape();      
    vertex(edge, edge);
    vertex(-edge, edge);
    vertex(-edge, -edge);
    vertex(edge, -edge);
    endShape(CLOSE);
  }
  
