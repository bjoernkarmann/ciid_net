  
  Table networkData;
  Table sortedData = new Table();
  
  int mID = 0;
  String fullName;
  String totalComp;
  String[] newTotalComp;
  
  
  void setup() {
    networkData = loadTable("data/networkdata.csv", "header"); 
    
    sortedData.addColumn("id");
    sortedData.addColumn("year");
    sortedData.addColumn("name");
      
    for (TableRow row : networkData.rows()) { 
      int       id         = row.getInt("id");
      int       year       = row.getInt("year");
      String    firstName  = row.getString("first name");
      String    middleName = row.getString("middle/other names");
      String    lastName   = row.getString("last name");
      String    curComp    = row.getString("current");
      String    prevComp   = row.getString("prev");
      
      TableRow newRow = sortedData.addRow();
      
      if(middleName.equals("")) {
        fullName = firstName + " " + lastName;
      } else {
        fullName = firstName + " " + middleName + " " + lastName;
      }
      
      if(curComp.equals("")) {
        totalComp = prevComp;
      }
      else if(prevComp.equals("")) {
        totalComp = curComp;
      }
      else {
        totalComp = curComp + ", " + prevComp;
      }
      
      newTotalComp = totalComp.split(", ");
      
      newRow.setInt("id", mID); 
      newRow.setInt("year", year);
      newRow.setString("name", fullName);
      
      for(int i=0; i<newTotalComp.length; i++) {
        newRow.setString("c"+i, newTotalComp[i]);
      }
      


      
      saveTable(sortedData, "data/new.csv");


    mID++;


    }
    
    saveTable(sortedData, "data/new.csv");
    
    println("yolo we're done");
  }
  
  void draw() {
    
  }  