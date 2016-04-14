class wordObject {
  int index;
  float x;
  float y;
  float leftBound;
  float rightBound;
  float topBound;
  float botBound;
  float centerX;
  float centerY;
  int wordLength;
  String target;
  String related;
  boolean isRelated = false;
  boolean isSelected = false;

  wordObject(int _index, float _x, float _y, String _target, String _related, int _wordLength) {
    index = _index;
    x = _x;
    y = _y;
    target = _target;
    related = _related;
    wordLength = _wordLength;

    leftBound   =  x * charWidth - 2;
    rightBound  =  x * charWidth + (wordLength * charWidth) + 2;
    topBound    =  (y * leading) - leading;
    botBound    =  (y * leading);
    
    centerX     = (leftBound + rightBound)/2;
    centerY     = (topBound  +   botBound)/2;
  }

  void printData() {
    println(leftBound+","+rightBound+","+topBound+","+botBound+"\t\t"+target);
  }

  void checkClicked(wordObject _tempWord) {
    if (mouseX - paddingX > _tempWord.leftBound && mouseX - paddingX < _tempWord.rightBound && mouseY - paddingY > _tempWord.topBound && mouseY - paddingY < _tempWord.botBound) {
      highlightSelected(_tempWord);
    }
  }
  
  void highlightSelected(wordObject _curWord) {
    wordObject workWord = _curWord;
    if (!workWord.isSelected) {
        for (int k=0; k<allWords.size(); k++) {
          allWords.get(k).isRelated = false;
          allWords.get(k).isSelected = false;
        }
        workWord.isSelected = true;
        anythingSelected = true;
        
        highlightRelated(workWord.related);
      } else if (workWord.isSelected) {
        for (int k=0; k<allWords.size(); k++) {
          allWords.get(k).isRelated = false;
          allWords.get(k).isSelected = false;
        }
        workWord.isSelected = false;
        anythingSelected = false;
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