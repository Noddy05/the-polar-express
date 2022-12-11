PImage smokeTexture;
PImage trainTexture;
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Particle> remove = new ArrayList<Particle>();
float lifeTime = 2;

void setup(){
  size(400, 400);
  smokeTexture = loadImage("smoke.png");
  trainTexture = loadImage("train.png");
}
void draw(){
  background(30);
  image(trainTexture, 0, 0, width, height);
  //Set center at chimney
  particles.add(new Particle(new PVector((242.0 / 400) * width, (137.0 / 400) * height), 
    PVector.fromAngle(random(PI + HALF_PI - 0.3, PI + HALF_PI + 0.3))
    .mult(random(80 * (width / 400), 130 * (width / 400))), 
    random(10 * (width / 400), 40 * (width / 400)), random(TWO_PI)));
    
  for(Particle particle : particles){
    particle.update();
    particle.draw();
  }
  for(Particle particle : remove){
    particles.remove(particle);
  }
  remove = new ArrayList<Particle>();
}
