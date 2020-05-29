Particle[] particles;
float alpha;
float heleCirkel = TWO_PI;

void setup() {
  size(900, 400);
  background(0);
  noStroke();
  setParticles();
}

void draw() {
  frameRate(20);
  alpha = map(mouseX, 0, width, 5, 35);
  fill(0, alpha);
  rect(0, 0, width, height);
  
  loadPixels();
  for (Particle p : particles) {
    p.move();
  }
  updatePixels();
  clock();
}

void setParticles() {
  particles = new Particle[10000];
  for (int i = 0; i < 10000; i++) { 
    float x = random(width);
    float y = random(height);
    float adj = map(y,0, x, 255, 0);
    int c = color(40, adj, 255);
    particles[i]= new Particle(x, y, c);
  }
}
class Particle {
  float posX, posY, incr, pathway;
  color  c;

  Particle(float xIn, float yIn, color cIn) {
    posX = xIn;
    posY = yIn;
    c = cIn;
  }

  public void move() {
    update();
    wrap();
    display();
  }

  void update() {
    incr +=  alpha/1000;
    pathway = noise(posX * .006, posY * .004, incr) * TWO_PI;
    posX += 2 * cos(pathway);
    posY += 2 * sin(pathway);
  }

  void display() {
    if (posX > 0 && posX < width && posY > 0  && posY < height) {
      pixels[(int)posX + (int)posY * width] =  c;
    }
  }
  void wrap() {
    if (posX < 0) posX = width;
    if (posX > width ) posX =  0;
    if (posY < 0 ) posY = height;
    if (posY > height) posY =  0;
  }
  void mousePressed() {
  setParticles();
  }
}
  public void clock(){
    translate(width/2,height/2);
  rotate(-heleCirkel/4);
  
  noFill();
  strokeWeight(20);
  strokeCap(SQUARE);

  stroke(0, 255, 0);
  float s = map(second(), 0, 60, 0, heleCirkel);
  arc(0, 0, 70, 70, 0, s);

  stroke(255, 0, 0);
  float m = map(minute(), 0, 60, 0, heleCirkel);
  arc(0, 0, 120, 120, 0, m);

  stroke(0, 0, 255);
  float h = map(hour(), 0, 60, 0, heleCirkel);
  arc(0, 0, 170, 170, 0, h);
  }
