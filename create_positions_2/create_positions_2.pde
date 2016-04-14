Table table;


ArrayList<wordObject> allWords = new ArrayList<wordObject>();

//TYPEPOGRAPHY
int textSize = 7;
float kerning = textSize * 0.7;
float leading = textSize * 1.3;
float charWidth = textSize / 1.4;
int paddingX = 40;
int paddingY = 60;
float space = 1.2;
PFont ocr;

void settings(){
  size(600,900,FX2D);
}

void setup(){
  frameRate(60);
  smooth();
  ocr = createFont("../data/OCRAStd.otf", textSize, true);

  table = loadTable("../data/horse.csv", "header");
  table.addColumn("x");
  table.addColumn("y");

  int col = 0;
  int row = 0;
  for (TableRow rowCount : table.rows()){
      String word = rowCount.getString("target").trim();
      String related = rowCount.getString("related");
      int wordLength = word.length();      
         
      rowCount.setInt("x", col);  
      rowCount.setInt("y", row);  
      
      allWords.add(new wordObject(col, row, word, related, wordLength));
      
      col += wordLength+space;
      
      if(col>95){
        col=0;
        row++;
      };
  }
}


void draw(){
  background(255);
  translate(paddingX,paddingY);
  for(int i=0; i<allWords.size(); i++) {
    wordObject curWord = allWords.get(i);
    
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
   //for (TableRow rowCount : table.rows()){
   //  String target   = rowCount.getString("target").toLowerCase();      
   //  String related  = rowCount.getString("related").toLowerCase();
   //  float x         = rowCount.getFloat("x");
   //  float y         = rowCount.getFloat("y");
      
   //  //println(x+","+y+"\t\t"+target);
   //  fill(0);
   //  textFont(ocr);
   //  textMode(SHAPE);
   //  text(target,x*kerning,y*leading);
   //} 
    
}

void mouseClicked() {
  for(int i=0; i<allWords.size(); i++) {
    wordObject curWord = allWords.get(i);
    curWord.checkClicked(mouseX, mouseY);
  }
}