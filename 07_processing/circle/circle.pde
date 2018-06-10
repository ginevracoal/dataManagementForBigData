int nCircles = 10;
Circle[] circles = {};   

void setup() {
  size(800, 500); 
  background(255);
  smooth();
  strokeWeight(1);
  fill(150, 50);
  newCircles();
}

void draw() {
  background(255);
  for (int i=0; i < circles.length; i++) {
    // move bubbles
    circles[i].moveMe();
    // draw bubbles
    circles[i].drawMe();
    // draw links
    circles[i].linkMe();
  }
}

void newCircles() {
  for (int i=0; i < nCircles; i++) { 
    circles = (Circle[]) append(circles, new Circle(circles.length));
  }
}

void mouseReleased() {
  newCircles();
}


class Circle {

  int id; // identificatore univoco
  float x, y; // coordinate del centro
  float radius; // raggio
  color fillcol; // colori del contenuto 
  float alpha; // trasparenza
  float xmove, ymove; // vettore di movimento (direzione e velocità)
  
  Circle(int _id) {
    id = _id;
    x = random(width);
    y = random(height);
    radius = random(10, 100); 
    fillcol = color(random(255), random(255), random(255));
    alpha = random(255);
    xmove = random(-2, 2);   
    ymove = random(-2, 2);  
  }
  
  void drawMe() { 
    noStroke(); 
    fill(fillcol, alpha);
    ellipse(x, y, radius*2, radius*2);
  }
  
  void moveMe() {
    x += xmove;
    y += ymove;
    if (x > (width + radius))   x = 0 - radius; 
    if (x < (0 - radius))       x = width + radius; 
    if (y > (height + radius))  y = 0 - radius; 
    if (y < (0 - radius))       y = height + radius; 
    // bouncing
    //if ( (x > (width - radius))  | (x < radius) )  xmove *= -1; 
    //if ( (y > (height - radius)) | (y < radius) )  ymove *= -1; 
  }
  
  void linkMe() {
    for (int i = id + 1; i < circles.length; i++) {
      float dis = dist(x, y, circles[i].x, circles[i].y); 
      float overlap = dis - radius - circles[i].radius; 
      if (overlap < 0) { 
        stroke(0);
        line(x, y, circles[i].x, circles[i].y);
        //float control = 50;
        //bezier(x, y, x+control, y+control, circles[i].x-control, circles[i].y-control, circles[i].x, circles[i].y);
      }
    } 
  }
  
}
