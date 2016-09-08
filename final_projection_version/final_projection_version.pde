import processing.pdf.*;

Table table;
ArrayList<wordObject> allWords = new ArrayList<wordObject>();
wordObject dummyWord = new wordObject(1000, 0, 0, "yolo", "dummy", 4);
headerObject searchHeader;

//TYPOGRAPHY
int letterMax = 99;
char searchLetter;
float headerTextSize = 20;
float headerKerning = headerTextSize * 0.7;
float textSize = 6.4;
float kerning = textSize * 0.7;
float leading = textSize * 1.4;
float charWidth = textSize / 1.4;
int paddingX = 55;
int paddingY = 115;
float space = 0.5;
PFont ocr;
int headerOffsetY = 40;

float plusPaddingX = 685;//  translate(685, 131.6);
float plusPaddingY = 136.6;

boolean newQuery = true;
boolean anythingSelected = false;
boolean leftPressed = false;
boolean rightPressed = false;
int counter = 0;

void settings() {
  //size(600, 900, FX2D);
  fullScreen();
}

void setup() {
  smooth();
  textSize(textSize);
  ocr = createFont("../data/OCRAStd.otf", textSize, true);

  table = loadTable("../data/duck.csv", "header");
  table.addColumn("x");
  table.addColumn("y");

  int col = 0;
  int row = 0;

  searchHeader = new headerObject(headerTextSize);

  for (TableRow rowCount : table.rows()) {
    String word = rowCount.getString("target").trim();
    String related = rowCount.getString("related");
    int wordLength = word.length();      

    rowCount.setInt("x", col);  
    rowCount.setInt("y", row);  

    allWords.add(new wordObject(counter, col, row, word, related, wordLength));

    col += wordLength + space;

    if (col>letterMax) {
      col=0;
      row++;
    }
    counter++;
  }
}


void draw() {
  noStroke();
  //beginRecord(PDF, "../data/pdf.pdf");
  noCursor();
  background(0);
  scale(0.954);
  
  
  pushStyle();
  fill(255);
  
  if (!anythingSelected) {
    rect(642, 113, 689, 959);
  }

  popStyle();
  pushStyle();
  if(anythingSelected)
    fill(255);
  else 
    fill(0);
  ellipse(mouseX - 2, mouseY - 2, 4, 4);
  popStyle();

  translate(plusPaddingX, plusPaddingY);
  println(mouseX, mouseY);

  translate(paddingX, paddingY);

  drawLines();

  for (int i=0; i<allWords.size(); i++) {
    wordObject curWord = allWords.get(i);

    if (curWord.x>letterMax-5) {
      String[] list = split(curWord.target, " ");
      //println(list.length);

      if (list.length == 2) {
        curWord.target = list[0];
      }
      if (list.length > 2) {
        curWord.target = list[0]+list[1];
      }
    }

    if (anythingSelected) { 
      if (curWord.isSelected) {
        fill(255);
        rect(curWord.leftBound+1, curWord.topBound + 4, curWord.boxWidth - 1, curWord.boxHeight - 2, 1);
        fill(0);
      } else if (curWord.isRelated) {
        fill(255);
        rect(curWord.leftBound+1, curWord.topBound + 4, curWord.boxWidth - 1, curWord.boxHeight - 2, 1);
        fill(0);
      } else
        fill(0);
    } else 
    fill(255);

    textFont(ocr);

    textMode(SHAPE);
    text(curWord.target, curWord.x*charWidth, curWord.y*leading);

    textSize(headerTextSize);
    if(anythingSelected)
      fill(255);
    else 
      fill(0);
    text(searchHeader.contents, 0, -headerOffsetY);
    if (!newQuery) {
      stroke(255);
      strokeWeight(3.5);
      line(searchHeader.contents.length() * headerKerning - (headerKerning/2) + 5, -headerOffsetY, searchHeader.contents.length() * headerKerning + headerKerning, -headerOffsetY);
      noStroke();  
  }
  }
  //endRecord();
}

void mouseClicked() {
  for (int i=0; i<allWords.size(); i++) {
    wordObject curWord = allWords.get(i);
    curWord.checkClicked(curWord);
  }
}

void keyPressed() {

  if (key == CODED) {
    if (!anythingSelected) {
      println("nothing selected");
    } else {
      if (keyCode == LEFT) {
        for (int i=0; i<allWords.size(); i++) {
          if (allWords.get(i).isSelected) {
            if (i>0) {
              allWords.get(i).highlightSelected(allWords.get(i-1));
              return;
            } else {
              return;
            }
          }
        }
      } else if (keyCode == RIGHT) {
        for (int i=0; i<allWords.size(); i++) {
          if (allWords.get(i).isSelected) {
            if (i<allWords.size()-1) {
              allWords.get(i).highlightSelected(allWords.get(i+1));
              return;
            } else {
              return;
            }
          }
        }
      } else if (keyCode == UP) {
        boolean wordSet = false;
        float centDist = 10000;
        float tempCentDist;
        wordObject tempWord = dummyWord;

        for (int i=0; i<allWords.size(); i++) {
          if (!wordSet) {
            if (allWords.get(i).isSelected) {
              tempWord = allWords.get(i);
              i = 0;
              wordSet = true;
            }
          } else {
            if (allWords.get(i).y == tempWord.y - 1) {
              tempCentDist = sqrt(pow(abs(allWords.get(i).centerX - tempWord.centerX), 2) + pow(abs(tempWord.centerY - tempWord.centerY), 2));
              if (tempCentDist < centDist) {
                centDist = tempCentDist;
                allWords.get(i).highlightSelected(allWords.get(i));
              }
            }
          }
        }
      } else if (keyCode == DOWN) {
        boolean wordSet = false;
        float centDist = 10000;
        float tempCentDist;
        wordObject tempWord = dummyWord;

        for (int i=0; i<allWords.size(); i++) {
          if (!wordSet) {
            if (allWords.get(i).isSelected) {
              tempWord = allWords.get(i);
              i = 0;
              wordSet = true;
            }
          } else {
            if (allWords.get(i).y == tempWord.y + 1) {
              tempCentDist = sqrt(pow(abs(allWords.get(i).centerX - tempWord.centerX), 2) + pow(abs(tempWord.centerY - tempWord.centerY), 2));
              if (tempCentDist < centDist) {
                centDist = tempCentDist;
                allWords.get(i).highlightSelected(allWords.get(i));
              }
            }
          }
        }
      }
    }
  }
  if ((key >= 'A' && key <= 'z') || (key >= '0' && key <= '9') ||key == ' ' || key == '/' || key == '-') {
    if (newQuery) {
      searchHeader.contents = "" + key;
      newQuery = false;
    } else {
      searchLetter = key;
      searchHeader.contents += key;
      searchHeader.contents = searchHeader.contents.toLowerCase();
    }
  } 
  if (key == BACKSPACE) {
    if(searchHeader.contents.length() > 0)
      searchHeader.contents = searchHeader.contents.substring(0, searchHeader.contents.length()-1).toLowerCase();
    else 
      searchHeader.contents = "";
  }
  if (key == ENTER || key == RETURN) {
    searchHeader.searchString(searchHeader.contents);
    newQuery = true;
  }
  if (key == TAB) {
    int randomNode = int(random(0, allWords.size()));
    allWords.get(randomNode).highlightSelected(allWords.get(randomNode));
  }
}


void drawLines() {
  pushStyle();
  stroke(200, 200, 255);
  wordObject currentSelected = dummyWord;
  boolean wordSet = false;
  for (int i=0; i<allWords.size(); i++) {
    if (!wordSet) {
      if (allWords.get(i).isSelected) {
        currentSelected = allWords.get(i);
        wordSet = true;
        i = 0;
      }
    } else {
      if (allWords.get(i).isRelated) {
        line(allWords.get(i).centerX, allWords.get(i).centerY + 2, currentSelected.centerX, currentSelected.centerY + 2);
      }
    }
  }
  popStyle();
}

void keyTyped() {
}