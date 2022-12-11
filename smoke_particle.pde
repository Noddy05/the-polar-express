

class Particle {

  PVector position, velocity;
  float size, rotation;
  int spawnMillis;
  PVector startPosition;

  Particle(PVector position, PVector velocity, float size, float rotation) {
    this.position = position;
    startPosition = position;
    this.velocity = velocity;
    this.size = size;
    this.rotation = rotation;
    spawnMillis = millis();
  }

  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);

    tint(255, (lifeTime - min((millis() - spawnMillis) / 1000.0, lifeTime)) * 255);
    image(smokeTexture, -size / 2, -size / 2, size, size);
    popMatrix();
  }

  void update() {
    if ((millis() - spawnMillis) / 1000.0 > lifeTime)
      remove.add(this);
    position = interpolate(startPosition, startPosition.copy().add(velocity),
      min((millis() - spawnMillis) / (1000.0 * lifeTime), 1));
    startPosition.x -= wind(position.y) * 3 * (width / 400);
  }

  float wind(float y) {
    return noise(0, y) * random((millis() - spawnMillis) / (1200 * lifeTime), 
      (millis() - spawnMillis) / (800 * lifeTime));
  }
}

//Smoothstep-ish, just using cos
float interpolate(float a, float b, float t) {
  return a + (b - a) * (logBased(sqrt(t/1.1 + 0.1), 10) + 1);
}

float logBased (float a, int b) {
  return (log(a) / log(b));
}

PVector interpolate(PVector a, PVector b, float t) {
  return new PVector(interpolate(a.x, b.x, t), interpolate(a.y, b.y, t));
}
