MatricesClass matrices;

int imageWidth;
int imageHeight;
Boolean done = false;

color sim;
color base;

PImage testImage;
PImage outImage;

String type = "ach";

void setup() {
  //base = color(100, 0, 98);
  PImage testImage = loadImage("neutralLUT.jpg");
  image(testImage, 0, 0);

  imageWidth = testImage.width;
  imageHeight = testImage.height;
  
  size(500, 500);
  outImage = new PImage(imageWidth, imageHeight);


  matrices = new MatricesClass();

  int start = millis();

  //// Fancy Filters
  for (int y = 0; y < imageHeight+1; y++) {
    for (int x = 0; x < imageWidth+1; x++) {
      color thisPix = testImage.get(x, y);

      color newColour = simulateColour(thisPix, type);
      outImage.set(x, y, newColour);
      print("done: " + x + " " + y + "\n");
    }
  }

  ////Quick Filters
  //for (int y = 0; y < imageHeight+1; y++) {
  //  for (int x = 0; x < imageWidth+1; x++) {
  //    color thisPix = testImage.get(x, y);
  //    int r = (int) red(thisPix);
  //    int g = (int) green(thisPix);
  //    int b = (int) blue(thisPix);
  //    int v = (int) ((r + g + b)/3);
  //    print(v + "    ");
  //    color newColour = color(v);
  //    outImage.set(x, y, newColour);
  //  }
  //}


  int timer = millis() - start;
  print("took " + timer + "ms");
}

//void draw() {
//  sim = simulateColour(base, "tri");
//  background(255);
//  fill(base);
//  rect(50, 50, 200, 200);
//  //print(red(sim) + " " + green(sim) + " "+ blue(sim));
//  fill(sim);
//  rect(300, 50, 200, 200);
//}

void draw() {
  image(outImage, 0, 0);
  if (done == false) {
    outImage.save(dataPath(type + ".png"));
    done = true;
  }
}


color simulateColour(color c, String type) {
  String colourBlindnessType = type;
  float[] LinearRGB = new float[3];
  LinearRGB[0] = red(c) / 255;
  LinearRGB[1] = green(c) / 255;
  LinearRGB[2] = blue(c) / 255;

  float[] gcLinearRGB= new float[3];

  for (int i = 0; i < 3; i++) {
    if (LinearRGB[i] <= 0.04045) {
      gcLinearRGB[i] =  ((LinearRGB[i])/12.92);
    } else {
      gcLinearRGB[i] = pow((((LinearRGB[i])+0.055)/1.055), 2.4);
    }
  }

  //print(gcLinearRGB[0] + " " + gcLinearRGB[1] + " " + gcLinearRGB[2] + " ");

  float[] LMS = new float[3];
  LMS = matrices.multiplyMatrices(gcLinearRGB, matrices.ConvertMatrix);
  //print(LMS[0] + " " + LMS[1] + " " + LMS[2] + " ");

  float[] SimLMS = new float[3];

  if (colourBlindnessType == "pro") {
    SimLMS = matrices.multiplyMatrices(LMS, matrices.Protanopia);
  } else if (colourBlindnessType == "deu") {
    SimLMS = matrices.multiplyMatrices(LMS, matrices.Deuteranopia);
  } else if (colourBlindnessType == "tri") {
    SimLMS = matrices.multiplyMatrices(LMS, matrices.Tritanopia);
  } else if (colourBlindnessType == "ach") {
    SimLMS = matrices.multiplyMatrices(LMS, matrices.Achromatopia);
  }

  float[] gcSimRGB = new float[3];
  gcSimRGB = matrices.multiplyMatrices(SimLMS, matrices.InverseConvertMatrix);

  float[] simRGB = new float[3];

  for (int i = 0; i < 3; i++) {
    if (gcSimRGB[i] <= 0.0031308) {
      simRGB[i] =  ((gcSimRGB[i])*12.92);
    } else {
      simRGB[i] = pow(1.055*gcSimRGB[i], 0.41666) -0.055;
    }
  }

  sim = color(simRGB[0] * 255, simRGB[1] * 255, simRGB[2] * 255);

  return sim;
}
