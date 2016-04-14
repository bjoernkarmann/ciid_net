class wordObject {
  float x;
  float y;
  float leftBound;
  float rightBound;
  float topBound;
  float botBound;
  int wordLength;
  String target;
  String related;
  
  wordObject(float _x, float _y, String _target, String _related, int _wordLength) {
    x = _x;
    y = _y;
    target = _target;
    related = _related;
    wordLength = _wordLength;
    
    leftBound   =  x * charWidth - 2;
    rightBound  =  x * charWidth + (wordLength * charWidth) + 2;
    topBound    =  (y * leading) - 2;
    botBound    =  (y * leading) + leading;
  }
  
  void printData() {
    println(leftBound+","+rightBound+","+topBound+","+botBound+"\t\t"+target);
  }
  
  void checkClicked(float _mouseX, float _mouseY) {
    float mousePosX = _mouseX;
    float mousePosY = _mouseY;
    
    if(mouseX - paddingX > leftBound && mouseX - paddingX < rightBound && mouseY - paddingY > topBound && mouseY - paddingY < botBound) {
      //println((mouseX) + ", " + (mouseY) + ", " + leftBound + ", " + rightBound + ", " + topBound + ", " + botBound);
      println(target);
    }
  }
}