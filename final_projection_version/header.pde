class headerObject {
  float textSize;
  String contents = "type to search";


  headerObject(float _textSize) {
    textSize = _textSize;
  }


  void searchString(String _contents) {
    contents = _contents.toLowerCase();
    if (contents.length() >= 3) {
      for (int i=0; i<allWords.size(); i++) {
        if(allWords.get(i).target.equals(contents)) {
          allWords.get(i).highlightSelected(allWords.get(i));
          return;
        } else if (allWords.get(i).target.contains(contents)) {
          allWords.get(i).highlightSelected(allWords.get(i));
        }
      }
    }
  }
}