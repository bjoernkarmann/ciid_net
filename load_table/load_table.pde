  Table table;
  Table sortedTable;
  
  int rowCount = 0;
  int colCount = 4;
  TableRow oldRow;
  
  void setup() {
    
    table = loadTable("../networkmerge/data/new.csv", "header");
    rowCount = table.getRowCount();
    
    sortedTable = new Table();
    sortedTable.addColumn("target");
    sortedTable.addColumn("related");    
    
      
    //===============================//
    //        SORT BY YEAR           //
    //===============================//
    
    
    for(int i=0; i<9; i++){

      String[] task = {"year","name","c0","c1","c2","c3","c4","c5","c6","c7","c8"};
      
      table.sort(task[i]);
      
      String prevRow = "0";
      for(TableRow row : table.rows()){
        String year      = row.getString("year"); 
        String name      = row.getString("name");
        String c0        = row.getString("c0"); 
        String c1        = row.getString("c1"); 
        String c2        = row.getString("c2"); 
        String c3        = row.getString("c3"); 
        String c4        = row.getString("c4"); 
        String c5        = row.getString("c5"); 
        String c6        = row.getString("c6");
        String c7        = row.getString("c7"); 
        String c8        = row.getString("c8"); 
        
        // Year
        if(i==0){
          if(year.equals(prevRow)) {
            String everything = oldRow.getString("related");
            oldRow.setString("related", everything + ","+name);          
          } else {
            TableRow newSortedRow = sortedTable.addRow();
            newSortedRow.setString("target", year);
            newSortedRow.setString("related", name);        
            oldRow = newSortedRow;
          }
        }
        
        // NAMES
        if(i==1){
          if(year.equals(prevRow)) {
            String everything = oldRow.getString("related");
            oldRow.setString("related", everything + ","+year+","+c0+","+c1+","+c2+","+c3+","+c4+","+c5+","+c6+","+c7+","+c8);          
          } else {
            TableRow newSortedRow = sortedTable.addRow();
            newSortedRow.setString("target", name);
            newSortedRow.setString("related", year+","+c0+","+c1+","+c2+","+c3+","+c4+","+c5+","+c6+","+c7+","+c8);        
            oldRow = newSortedRow;
          }
        }
        
        // COMPANIE 0
        if(i==1){
          if(c0.equals("")){}else{
            if(year.equals(prevRow)) {
              String everything = oldRow.getString("related");
              oldRow.setString("related", everything+","+name);          
            } else {
              TableRow newSortedRow = sortedTable.addRow();
              
              newSortedRow.setString("target", c0);
              newSortedRow.setString("related", name);        
              oldRow = newSortedRow;
            }
          }
        }
        
        // COMPANIE 1
        if(i==2){
          if(c1.equals("")){}else{
            if(year.equals(prevRow)) {
              String everything = oldRow.getString("related");
              oldRow.setString("related", everything+","+name);          
            } else {
              TableRow newSortedRow = sortedTable.addRow();
              newSortedRow.setString("target", c1);
              newSortedRow.setString("related", name);        
              oldRow = newSortedRow;
            }
          }
        }
        
        // COMPANIE 2
        if(i==3){
          if(c2.equals("")){}else{
            if(year.equals(prevRow)) {
              String everything = oldRow.getString("related");
              oldRow.setString("related", everything +","+name);          
            } else {
              TableRow newSortedRow = sortedTable.addRow();
              newSortedRow.setString("target", c2);
              newSortedRow.setString("related", name);        
              oldRow = newSortedRow;
            }
          }
        }
        // COMPANIE 3
        if(i==4){
          if(c3.equals("")){}else{
            if(year.equals(prevRow)) {
              String everything = oldRow.getString("related");
              oldRow.setString("related", everything+","+name);          
            } else {
              TableRow newSortedRow = sortedTable.addRow();
              newSortedRow.setString("target", c3);
              newSortedRow.setString("related", name);        
              oldRow = newSortedRow;
            }
          }
        }
        // COMPANIE 4
        if(i==5){
          if(c4.equals("")){}else{
            if(year.equals(prevRow)) {
              String everything = oldRow.getString("related");
              oldRow.setString("related", everything + ","+name);          
            } else {
              TableRow newSortedRow = sortedTable.addRow();
              newSortedRow.setString("target", c4);
              newSortedRow.setString("related", name);        
              oldRow = newSortedRow;
            }
          }
        }        
        // COMPANIE 5
        if(i==6){
          if(c5.equals("")){}else{
            if(year.equals(prevRow)) {
              String everything = oldRow.getString("related");
              oldRow.setString("related", everything + ","+name);          
            } else {
              TableRow newSortedRow = sortedTable.addRow();
              newSortedRow.setString("target", c5);
              newSortedRow.setString("related", name);        
              oldRow = newSortedRow;
            }
          }
        }
        // COMPANIE 6
        if(i==7){
          if(c6.equals(" ")){}else{
            if(year.equals(prevRow)) {
              String everything = oldRow.getString("related");
              oldRow.setString("related", everything + ","+name);          
            } else {
              TableRow newSortedRow = sortedTable.addRow();
              newSortedRow.setString("target", c6);
              newSortedRow.setString("related", name);        
              oldRow = newSortedRow;
            }
          }
        }
                      
        prevRow = year;
        rowCount++;
      }   
    }
    
    //===============================//
    //         PRINT RESULT          //
    //===============================//
    
    sortedTable.sort("target");
    for(TableRow row : sortedTable.rows()){
      String target = row.getString("target").toLowerCase();
      String related = row.getString("related").toLowerCase();
      
       println(target+"\t\t\t"+related);
      
      
    }
   println(sortedTable.getRowCount());
  }
  
  void draw() {
    
  }