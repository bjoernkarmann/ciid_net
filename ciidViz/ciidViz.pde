import processing.pdf.*;

Table table;
PFont ocr;
String target;

int textSize = 8;
float kerning = textSize * 0.7;
float leading = textSize * 1.3;

int paddingX = 10;
int paddingY = 10;
int y;
int x = 0;
int xLastSpace;

void setup() {
  size(600, 900, P3D);
  //size(600,900, PDF, "pdf.PDF");
  pixelDensity(2);
  smooth();
  background(255);

  ocr = createFont("OCRAStd.otf", textSize, true);

  table = loadTable("data/horse.csv", "header");

  translate(paddingX, paddingY);

  for (TableRow row : table.rows()) {
    target = target + row.getString("target").toLowerCase() + " ";
  }

    noStroke();
    fill(255, 0, 0);
    rect(18*kerning, 4*leading + 2, 5*kerning, leading + 2);
  for (int i=0; i<target.length(); i++) {
    x++;

    if (x * kerning > width - paddingX * 2) {          //NEWLINE
      //if(target.charAt(i) == ' ') {            //if last character is NOT a space
      //  xLastSpace = i;
      //} else {
      //}
      y++;
      x=0;
    }

//    if (x == 0 && target.charAt(i) == ' ') {
//      x--;
//    }
    
    fill(0);
    textFont(ocr);
    textMode(SHAPE);
    text(target.charAt(i), x*kerning, y*leading);
    //println(x);
  }

  println("done !");
  //exit();
}

void draw() {
}