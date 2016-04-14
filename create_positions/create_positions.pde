Table table;

//TYPEPOGRAPHY
int textSize = 7;
float kerning = textSize * 0.7;
float leading = textSize * 1.3;
int paddingX = 40;
int paddingY = 60;
float space = 1.2;
PFont ocr;

void settings(){
  size(600,900,FX2D);
}

void setup(){
  pixelDensity(2);
  smooth();
  ocr = createFont("../data/OCRAStd.otf", textSize, true);

  table = loadTable("../data/horse.csv", "header");
  table.addColumn("x");
  table.addColumn("y");

  int col = 0;
  int row = 0;
  for (TableRow rowCount : table.rows()){
      String word = rowCount.getString("target").trim();
      int wordLength = word.length();      
         
      rowCount.setInt("x", col);  
      rowCount.setInt("y", row);  
      col += wordLength+space;
      
      if(col>95){
        col=0;
        row++;
      };
  }
  
  
  
  //================//
  //    DRAW NEW    //
  //================//
  background(255);
  translate(paddingX,paddingY);
   for (TableRow rowCount : table.rows()){
      String target   = rowCount.getString("target").toLowerCase();      
      String related  = rowCount.getString("related").toLowerCase();
      float x         = rowCount.getFloat("x");
      float y         = rowCount.getFloat("y");
      
      println(x+","+y+"\t\t"+target);
      fill(0);
      textFont(ocr);
      textMode(SHAPE);
      text(target,x*kerning,y*leading);
   } 
}


void draw(){
  
}