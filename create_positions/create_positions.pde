import processing.pdf.*;

Table table;
ArrayList<wordObject> allWords = new ArrayList<wordObject>();
wordObject dummyWord = new wordObject(0, 0, "yolo", "dummy", 4);

//TYPEPOGRAPHY
int letterMax = 99;
float textSize = 6.4;
float kerning = textSize * 0.7;
float leading = textSize * 1.4;
float charWidth = textSize / 1.4;
int paddingX = 55;
int paddingY = 110;
float space = 1.2;
PFont ocr;

boolean anythingSelected = false;
boolean leftPressed = false;
boolean rightPressed = false;

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
  
  drawLines();
  
  for(int i=0; i<allWords.size(); i++) {
    wordObject curWord = allWords.get(i);
    
    if (curWord.x>letterMax-5) {
      String[] list = split(curWord.target, " ");
      //println(list.length);
      
      if(list.length == 2){
        curWord.target = list[0];
      }
      if(list.length > 2){
        curWord.target = list[0]+list[1];
      }
    }
    
    if(anythingSelected) {
      if(curWord.isSelected) 
        fill(0);
      else if(curWord.isRelated) 
        fill(0);
      else
        fill(175);
    } else 
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

//void keyPressed() {
// if(key == CODED) {
//   if(keyCode == LEFT) {
//     leftPressed = true;
//   } else if(keyCode == RIGHT) {
//     rightPressed = true;
//   }
// }
//}

void drawLines() {
  pushStyle();
  stroke(200, 200, 255);
  wordObject currentSelected = dummyWord;
  boolean wordSet = false;
  for(int i=0; i<allWords.size(); i++) {
    if(!wordSet) {
      if(allWords.get(i).isSelected) {
        currentSelected = allWords.get(i);
        wordSet = true;
        i = 0;
      }
    } else {
      if(allWords.get(i).isRelated) {
        line(allWords.get(i).centerX, allWords.get(i).centerY, currentSelected.centerX, currentSelected.centerY);
      }
    }
  }
  popStyle();
}