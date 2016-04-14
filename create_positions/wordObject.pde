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
  boolean isRelated = false;
  boolean isSelected = false;
  int counter = 0;

  wordObject(float _x, float _y, String _target, String _related, int _wordLength) {
    x = _x;
    y = _y;
    target = _target;
    related = _related;
    wordLength = _wordLength;

    leftBound   =  x * charWidth - 2;
    rightBound  =  x * charWidth + (wordLength * charWidth) + 2;
    topBound    =  (y * leading) - leading;
    botBound    =  (y * leading);
  }

  void printData() {
    println(leftBound+","+rightBound+","+topBound+","+botBound+"\t\t"+target);
  }

  void checkClicked() {
    if (mouseX - paddingX > leftBound && mouseX - paddingX < rightBound && mouseY - paddingY > topBound && mouseY - paddingY < botBound) {
      if (!this.isSelected) {
        for (int k=0; k<allWords.size(); k++) {
         allWords.get(k).isRelated = false;
         allWords.get(k).isSelected = false;
        }
        this.isSelected = true;
        highlightRelated(this.related);
      } else if(this.isSelected) {
        for (int k=0; k<allWords.size(); k++) {
          allWords.get(k).isRelated = false;
          allWords.get(k).isSelected = false;
        }
        this.isSelected = false;
      }
    }
  }

  void highlightRelated(String _related) {
    String newRelated[] = _related.split(",");
    for (int l=0; l<allWords.size(); l++) {
      for (int m=0; m<newRelated.length; m++) {
        if (allWords.get(l).target.equals(newRelated[m])) {
          allWords.get(l).isRelated = true;
        }
      }
    }
    
  }
}