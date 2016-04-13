import http.requests.*;


void setup(){  
  String[] list = getData().split("company/");  
  for(int i=1; i<5; i++){
    String[] company = splitTokens(list[i],"><");
    println(company[1]);
  }
}

void draw(){
}


String getData(){
  GetRequest get = new GetRequest("https://www.linkedin.com/in/nonlocal/");
  get.send();
  return get.getContent(); 
}