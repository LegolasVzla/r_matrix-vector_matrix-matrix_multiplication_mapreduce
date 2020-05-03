# Jose Prato 23185710 - Manuel Carrero 19821361

memlimit<-function(size){

  if(size==-1){
    limite<-  memory.limit()
    return (limite)
    
  }else{
    return (size)
  }
    
}

