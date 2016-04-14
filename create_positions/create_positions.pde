import processing.pdf.*;

Table table;

//TYPEPOGRAPHY
int letterMax = 99;
float textSize = 6.4;
float kerning = textSize * 0.7;
float leading = textSize * 1.4;
int paddingX = 55;
int paddingY = 110;
float space = 0;
PFont ocr;

void settings() {
  size(600, 900, FX2D);
}

void setup() {
  
  pixelDensity(2);
  smooth();
  ocr = createFont("../data/OCRAStd.otf", textSize, true);

  

  table = loadTable("../data/horse.csv", "header");
  table.addColumn("x");
  table.addColumn("y");

  int col = 0;
  int row = 0;
  
  for (TableRow rowCount : table.rows()) {
    String word = rowCount.getString("target").trim();
    int wordLength = word.length();      

    rowCount.setInt("x", col);  
    rowCount.setInt("y", row);  
    col += wordLength;
    
    if (col>letterMax) {
      col=0;
      row++;
    }
  }
}


void draw() {
  beginRecord(PDF, "../data/pdf.pdf");
  
  background(255);
  translate(paddingX, paddingY);
  
  
  for (TableRow rowCount : table.rows()) {
    String target   = rowCount.getString("target").toLowerCase();      
    String related  = rowCount.getString("related").toLowerCase();
    float x         = rowCount.getFloat("x");
    float y         = rowCount.getFloat("y");

    if (x>letterMax-5) {
      String[] list = split(target, " ");
      println(list.length);
      
      if(list.length == 2){
        target = list[0];
      }
      if(list.length > 2){
        target = list[0]+list[1];
      }
    }
    
    fill(0);
    textFont(ocr);
    text(target, x*kerning+space, y*leading);
    
    
    

        
  }
  
  endRecord();
  noLoop();
}