  
  Table networkData;
  Table sortedData = new Table();
  
  int mID = 0;
  
  
  void setup() {
    networkData = loadTable("data/networkdata.csv", "header"); 
    
    sortedData.addColumn("id");
    sortedData.addColumn("year");
    sortedData.addColumn("name");
    sortedData.addColumn("companies");
      
    for (TableRow row : networkData.rows()) { 
      int id = row.getInt("id");
      int year             = row.getInt("year");
      String    firstName  = row.getString("first name");
      String    middleName = row.getString("middle name");
      String    lastName   = row.getString("last name");
      String    curComp    = row.getString("current");
      String    prevComp   = row.getString("prev");
      
      TableRow newRow = sortedData.addRow();
      
      newRow.setInt("id", mID); 
      newRow.setInt("year", year);
      newRow.setString("name", firstName + " " + middleName + " " + lastName);
      newRow.setString("companies", curComp + ", " + prevComp);
      
      saveTable(sortedData, "data/new.csv");
    }
    
    println("yolo we're done");
    
    
    mID++;
  }
  
  void draw() {
    
  }  