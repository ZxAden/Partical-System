Particle[] particles;
float alpha;

void setup() {
  size(900, 200);
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
}

void setParticles() {
  particles = new Particle[6000];
  for (int i = 0; i < 6000; i++) { 
    float x = random(width);
    float y = random(height);
    float adj = map(y, 0, height, 255, 0);
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
    incr +=  .008;
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
