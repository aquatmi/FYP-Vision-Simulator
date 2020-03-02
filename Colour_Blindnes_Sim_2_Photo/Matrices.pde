class MatricesClass 
{
  public MatricesClass() {
  }

  public float[][] IMatrix = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}};

  public float[][] ConvertMatrix = 
    {{0.31399022, 0.63951294, 0.04649755}, 
    {0.15537241, 0.75789446, 0.08670142}, 
    {0.01775239, 0.10944209, 0.87256922}};

  public float[][] InverseConvertMatrix = 
    {{5.47221206, -4.6419601, 0.16963708}, 
    {-1.1252419, 2.29317094, -0.1678952}, 
    {0.02980165, -0.19318073, 1.16364789}};

  public float[][] Protanopia =
    {{0, 1.05118294, -0.05116099 }, 
    { 0, 1, 0 }, 
    { 0, 0, 1 }};

  public float[][] Deuteranopia =
    {{1, 0, 0 }, 
    { 0.9513092, 0, 0.04866992 }, 
    { 0, 0, 1 }};

  public float[][] Tritanopia =
    {{1, 0, 0 }, 
    { 0, 1, 0 }, 
    {-0.86744736, 1.86727089, 0 }};

  public float[][] Achromatopia =
    {{0, 0, 1 }, 
    { 0, 0, 1 }, 
    { 0, 0, 1 }};

  public float[] multiplyMatrices(float[] a, float[][] b) {
    float[] answer = new float[3];

    answer[0] = (a[0] * b[0][0]) + (a[1] * b[0][1]) + (a[2] * b[0][2]);
    answer[1] = (a[0] * b[1][0]) + (a[1] * b[1][1]) + (a[2] * b[1][2]);
    answer[2] = (a[0] * b[2][0]) + (a[1] * b[2][1]) + (a[2] * b[2][2]);

    return answer;
  }
}
