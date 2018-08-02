
float angleX = 0;
float angleY = 0;
float angleZ = 0;
PVector[][][] cube;

PVector[][][] makeCube(float r) {
  PVector[][][] cube = new PVector[2][2][2];
  int index = 0;
  for (int x = 0; x < 2; x++) {
    for (int y = 0; y < 2; y++) {
      for (int z = 0; z < 2; z++) {
        cube[x][y][z] = new PVector((x-0.5)*r, (y-0.5)*r, (z-0.5)*r);
        index++;
      }
    }
  }
  return cube;
}

void setup() {
  size(640, 480);
  cube = makeCube(100);
}


void draw() {
  background(0);
  translate(width/2, height/2);
  strokeWeight(4);
  stroke(255);

  PVector[][][] projected2d = new PVector[2][2][2];
  
  // 
  for (int x = 0; x < 2; x++) {
    for (int y = 0; y < 2; y++) {
      for (int z = 0; z < 2; z++) {
        projected2d[x][y][z] = project2d(cube[x][y][z]);
      }
    }
  }
  
  
  // All edges
  line(projected2d[0][0][0].x, projected2d[0][0][0].y, projected2d[1][0][0].x, projected2d[1][0][0].y);
  line(projected2d[0][0][0].x, projected2d[0][0][0].y, projected2d[0][1][0].x, projected2d[0][1][0].y);
  line(projected2d[0][0][0].x, projected2d[0][0][0].y, projected2d[0][0][1].x, projected2d[0][0][1].y);

  line(projected2d[1][0][0].x, projected2d[1][0][0].y, projected2d[1][1][0].x, projected2d[1][1][0].y);
  line(projected2d[1][0][0].x, projected2d[1][0][0].y, projected2d[1][0][1].x, projected2d[1][0][1].y);

  line(projected2d[0][0][1].x, projected2d[0][0][1].y, projected2d[1][0][1].x, projected2d[1][0][1].y);
  line(projected2d[0][0][1].x, projected2d[0][0][1].y, projected2d[0][1][1].x, projected2d[0][1][1].y);

  line(projected2d[0][1][0].x, projected2d[0][1][0].y, projected2d[1][1][0].x, projected2d[1][1][0].y);
  line(projected2d[0][1][0].x, projected2d[0][1][0].y, projected2d[0][1][1].x, projected2d[0][1][1].y);

  line(projected2d[1][1][1].x, projected2d[1][1][1].y, projected2d[1][1][0].x, projected2d[1][1][0].y);
  line(projected2d[1][1][1].x, projected2d[1][1][1].y, projected2d[0][1][1].x, projected2d[0][1][1].y);
  line(projected2d[1][1][1].x, projected2d[1][1][1].y, projected2d[1][0][1].x, projected2d[1][0][1].y);

  angleX += 0.03;
  angleY += 0.023;
  angleZ += 0.01234;
}


PVector project2d(PVector v) {
  Matrix projection = new Matrix(new float[][] {
    {1, 0, 0}, 
    {0, 1, 0}, 
    });

  Matrix rotationZ = new Matrix(new float[][] {
    {cos(angleZ), -sin(angleZ), 0}, 
    {sin(angleZ), cos(angleZ), 0}, 
    {0, 0, 1}
    });

  Matrix rotationX = new Matrix(new float[][] {
    {1, 0, 0}, 
    {0, cos(angleX), -sin(angleX)}, 
    {0, sin(angleX), cos(angleX)}, 
    });

  Matrix rotationY = new Matrix(new float[][] {
    {cos(angleY), 0, -sin(angleY)}, 
    {0, 1, 0}, 
    {sin(angleY), 0, cos(angleY)}
    });
  Matrix p1 = new Matrix(new float[][] {{v.x}, {v.y}, {v.z}});
  Matrix a1 = rotationZ.mult(p1);
  Matrix a2 = rotationY.mult(a1);
  Matrix a3 = rotationX.mult(a2);
  Matrix p2 = projection.mult(a3);
  return new PVector(p2.data[0][0], p2.data[1][0]);
}