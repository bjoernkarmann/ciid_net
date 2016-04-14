import processing.pdf.*;

Table table;
ArrayList<wordObject> allWords = new ArrayList<wordObject>();

//TYPEPOGRAPHY
int letterMax = 99;
float textSize = 6.4;
float kerning = textSize * 0.7;
float leading = textSize * 1.4;
float charWidth = textSize / 1.4;
int paddingX = 55;
int paddingY = 110;
float space = 0;
PFont ocr;

void settings() {
  size(600, 900, FX2D);
}

void setup() {
  smooth();
  ocr = createFont("../data/OCRAStd.otf", textSize, true);

  table = loadTable("../data/horse.csv", "header");
  table.addColumn("x");
  table.addColumn("y");

  int col = 0;
  int row = 0;
  for (TableRow rowCount : table.rows()) {
    String word = rowCount.getString("target").trim();
    String related = rowCount.getString("related");
    int wordLength = word.length();      

    rowCount.setInt("x", col);  
    rowCount.setInt("y", row);  
    
    allWords.add(new wordObject(col, row, word, related, wordLength));
      
    col += wordLength + space;
    
    if (col>letterMax) {
      col=0;
      row++;
    }
  }
}


void draw() {
  //beginRecord(PDF, "../data/pdf.pdf");
  
  background(255);
  translate(paddingX, paddingY);
  
  for(int i=0; i<allWords.size(); i++) {
    wordObject curWord = allWords.get(i);
    
    if (curWord.x>letterMax-5) {
      String[] list = split(curWord.target, " ");
      println(list.length);
      
      if(list.length == 2){
        curWord.target = list[0];
      }
      if(list.length > 2){
        curWord.target = list[0]+list[1];
      }
    }
    
    if(curWord.isSelected) 
      fill(0, 255, 0);
    else if(curWord.isRelated) 
      fill(255,0,0);
    else
      fill(0);
    textFont(ocr);
    textMode(SHAPE);
    text(curWord.target, curWord.x*charWidth, curWord.y*leading);
  }
  
  //endRecord();
}

void mouseClicked() {
  for(int i=0; i<allWords.size(); i++) {
    wordObject curWord = allWords.get(i);
    curWord.checkClicked();
  }
}