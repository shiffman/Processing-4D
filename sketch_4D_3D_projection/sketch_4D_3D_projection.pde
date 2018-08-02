
float angle1,angle2 = 0;
P4Vector[][][][] cube;

P4Vector[][][][] makeCube4(float r) {
  P4Vector[][][][] cube = new P4Vector[2][2][2][2];
  for (int x = 0; x < 2; x++) {
    for (int y = 0; y < 2; y++) {
      for (int z = 0; z < 2; z++) {
        for (int w = 0; w < 2; w++) {
          cube[x][y][z][w] = new P4Vector((x-0.5)*r, (y-0.5)*r, (z-0.5)*r, (w-0.5)*r*3);
        }
      }
    }
  }
  return cube;
}

void setup() {
  size(640, 480, P3D);
  cube = makeCube4(100);
}


void draw() {
  background(0);
  translate(width/2, height/2);
  strokeWeight(8);
  stroke(255);

  PVector[][][][] projected3d = new PVector[2][2][2][2];
  for (int x = 0; x < 2; x++) {
    for (int y = 0; y < 2; y++) {
      for (int z = 0; z < 2; z++) {
        for (int w = 0; w < 2; w++) {
          projected3d[x][y][z][w] = project3d(cube[x][y][z][w]);
        }
      }
    }
  }

  for (int x = 0; x < 2; x++) {
    for (int y = 0; y < 2; y++) {
      for (int z = 0; z < 2; z++) {
        for (int w = 0; w < 2; w++) {
          point(projected3d[x][y][z][w].x, projected3d[x][y][z][w].y, projected3d[x][y][z][w].z);
        }
      }
    }
  }
  
  strokeWeight(1);
 
  angle1 += 0.03;
  angle2 += 0.012;
}


PVector project3d(P4Vector v) {
  Matrix projection = new Matrix(new float[][] {
    {1, 0, 0, 0}, 
    {0, 1, 0, 0}, 
    {0, 0, 1, 0}, 
    });

  Matrix rotation1 = new Matrix(new float[][] {
    {1, 0, 0, 0}, 
    {0, 1, 0, 0}, 
    {0, 0, cos(angle2), -sin(angle2)}, 
    {0, 0, sin(angle2), cos(angle2)}, 
    });

  Matrix rotation2 = new Matrix(new float[][] {
    {cos(angle1), -sin(angle1), 0, 0}, 
    {sin(angle1), cos(angle1), 0, 0}, 
    {0, 0, 1, 0}, 
    {0, 0, 0, 1}, 
    });

  Matrix p1 = new Matrix(new float[][] {{v.x}, {v.y}, {v.z}, {v.w}});
  Matrix a1 = rotation2.mult(rotation1.mult(p1));
  Matrix p2 = projection.mult(a1);
  return new PVector(p2.data[0][0], p2.data[1][0], p2.data[2][0]);
}