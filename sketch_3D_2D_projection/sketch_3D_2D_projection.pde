
float angleX = 0;
float angleY = 0;
float angleZ = 0;
PVector v1 = new PVector(-100, -100, 0);
PVector v2 = new PVector(100, -100, 0);
PVector v3 = new PVector(100, 100, 0);
PVector v4 = new PVector(-100, 100, 0);

void setup() {
  size(640, 480);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  strokeWeight(4);
  stroke(255);
  PVector p1 = project2d(v1);
  PVector p2 = project2d(v2);
  PVector p3 = project2d(v3);
  PVector p4 = project2d(v4);
  line(p1.x, p1.y, p2.x, p2.y);
  line(p2.x, p2.y, p3.x, p3.y);
  line(p3.x, p3.y, p4.x, p4.y);
  line(p4.x, p4.y, p1.x, p1.y);
  angleX += 0.03;
  angleY += 0.03;
  angleZ += 0.03;
}


PVector project2d(PVector v) {
  Matrix projection = new Matrix(new float[][] {
    {1, 0, 0}, 
    {0, 1, 0} 
    });

  Matrix rotationZ = new Matrix(new float[][] {
    {cos(angleZ), -sin(angleZ), 0}, 
    {sin(angleZ), cos(angleZ), 0}, 
    {0, 0, 0}
    });

  Matrix rotationX = new Matrix(new float[][] {
    {1, 0, 0}, 
    {0, cos(angleX), -sin(angleX)}, 
    {0, sin(angleX), cos(angleX)}, 
    });

  Matrix rotationY = new Matrix(new float[][] {
    {cos(angleY), 0, -sin(angleY)}, 
    {0, 1, 0}, 
    {-sin(angleY), 0, cos(angleY)}
    });
  Matrix p1 = new Matrix(new float[][] {{v.x}, {v.y}, {v.z}});
  Matrix a1 = rotationZ.mult(p1);
  Matrix a2 = rotationY.mult(a1);
  Matrix a3 = rotationX.mult(a2);
  Matrix p2 = projection.mult(a3);
  return new PVector(p2.data[0][0], p2.data[1][0]);
}