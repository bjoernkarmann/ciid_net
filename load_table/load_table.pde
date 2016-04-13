  Table table;
  Table sortedTable;
  Table compressedTable;
 
  
  
  void setup() {
  
    table = loadTable("../networkmerge/data/new.csv", "header");

  
    sortedTable = new Table();
    sortedTable.addColumn("target");
    sortedTable.addColumn("related");    
  
  
    //===============================//
    //        SORT BY COLLUM         //
    //===============================//
  
  
    for (int i=0; i<11; i++) {
  
      String[] task = {"year", "name", "c0", "c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8"};
  
      table.sort(task[i]);
  
      //String prevRow = "0";
      for (TableRow row : table.rows()) {
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
  
        
        if (i==0) {  // Year
          TableRow newSortedRow = sortedTable.addRow();
          newSortedRow.setString("target", year);
          newSortedRow.setString("related", name);
        }
        if (i==1) {  // NAMES
          TableRow newSortedRow = sortedTable.addRow();
          newSortedRow.setString("target", name);
          newSortedRow.setString("related", year+","+c0+","+c1+","+c2+","+c3+","+c4+","+c5+","+c6+","+c7+","+c8);
        } 
        if (i==2) {  // COMPANIE 0
          TableRow newSortedRow = sortedTable.addRow();           
          newSortedRow.setString("target", c0);
          newSortedRow.setString("related", name);
        } 
        if (i==3) {  // COMPANIE 1
          TableRow newSortedRow = sortedTable.addRow();           
          newSortedRow.setString("target", c1);
          newSortedRow.setString("related", name);
        }
        if (i==4) {  // COMPANIE 2
          TableRow newSortedRow = sortedTable.addRow();           
          newSortedRow.setString("target", c2);
          newSortedRow.setString("related", name);
        }
        if (i==5) {  // COMPANIE 3
          TableRow newSortedRow = sortedTable.addRow();           
          newSortedRow.setString("target", c3);
          newSortedRow.setString("related", name);
        }
        if (i==6) {  // COMPANIE 4
          TableRow newSortedRow = sortedTable.addRow();           
          newSortedRow.setString("target", c4);
          newSortedRow.setString("related", name);
        }
        if (i==7) {  // COMPANIE 5
          TableRow newSortedRow = sortedTable.addRow();           
          newSortedRow.setString("target", c5);
          newSortedRow.setString("related", name);
        }
        if (i==8) {  // COMPANIE 6
          TableRow newSortedRow = sortedTable.addRow();           
          newSortedRow.setString("target", c6);
          newSortedRow.setString("related", name);
        }
        if (i==9) {  // COMPANIE 7
          TableRow newSortedRow = sortedTable.addRow();           
          newSortedRow.setString("target", c7);
          newSortedRow.setString("related", name);
        }
        if (i==10) {  // COMPANIE 8
          TableRow newSortedRow = sortedTable.addRow();           
          newSortedRow.setString("target", c8);
          newSortedRow.setString("related", name);
        }

      }
    }
  
    //===============================//
    //       COMPRESS DUBBLES        //
    //===============================//
    
    sortedTable.sort("target");
    
    compressedTable = new Table();
    compressedTable.addColumn("target");
    compressedTable.addColumn("related");
    
    TableRow oldRow = table.getRow(1000);
    String prevRow = "0";
    
    for (TableRow row : sortedTable.rows()) {
      String target = row.getString("target").toLowerCase();
      String related = row.getString("related").toLowerCase();
  
      if (target.equals(prevRow)) {
        String everything = oldRow.getString("related");
        oldRow.setString("related", everything+","+related);
      } else {
        TableRow newCompressedRow = compressedTable.addRow();           
        newCompressedRow.setString("target", target);
        newCompressedRow.setString("related", related); 
        oldRow = newCompressedRow;
      }  
      prevRow = target;
    }
    
    //===============================//
    //         PRINT RESULT          //
    //===============================//
   
    
    for (TableRow row : compressedTable.rows()) {
      String target = row.getString("target").toLowerCase();
      String related = row.getString("related").toLowerCase();
      
      println(target+"\t\t\t"+related);
    }
         
    saveTable(compressedTable, ".../data/sortedTable.csv");
    println(compressedTable.getRowCount());
  }
  
  void draw() {
  }