# Jose Prato 23185710 - Manuel Carrero 19821361

productmm <- function(matrizA,matrizB,N,limite_de_memoria){
  memoria_usada2 <- 0
  memoria_usada2 <- memoria_usada2 + object.size(memoria_usada2)

  ## Cargo la función de multiplicación de Matriz x Vector
  source("productmv.R")  
  con3 = file(matrizB, "r") # Se establece la conexión con el archivo de la matrizB  
  j <- 1
  memoria_usada2<- memoria_usada2+ object.size(j)
  for(i in 1:N){
    while(j <= N){
         
      line2 = readLines(con3, n = 1)  # Se toma la fila del vector
      memoria_usada2<- memoria_usada2 + object.size(line2)
      line2 <- strsplit(line2, split = ",")
      i_v <- as.integer(line2[[1]][[1]])  # Posición i del vector a generar
      v_v <- as.numeric(line2[[1]][[3]])  # Valor del vector
      memoria_usada2 <-memoria_usada2 + object.size(v_v)
      memoria_usada2 <-memoria_usada2 + object.size(i_v)
      memoria_usada2 <-memoria_usada2 - object.size(line2)
      
      setwd("C:/Users/Manuel/Desktop/proyectoicd/data")  # Se establece el directorio para el archivo de salida
      cat(i_v,file="vector_intermedio.csv",sep=",", append = TRUE)  # Se escribe en el archivo de salida la multiplicación
      cat(",",file="vector_intermedio.csv", append = TRUE)
      cat(v_v,file="vector_intermedio.csv",sep="\n", append = TRUE)
      memoria_usada2 <-memoria_usada2 - object.size(v_v)
      memoria_usada2 <-memoria_usada2 - object.size(i_v)
      j<-j+1;
    }
    j<-1
    productmv(matrizA,"C:/Users/Manuel/Desktop/proyectoicd/data/vector_intermedio.csv",N,limite_de_memoria)  # Función que realiza la multiplicación de matriz-vector
    #memoria_usada2 <-memoria_usada2 + object.size(productmv(matrizA,"C:/Users/Manuel/Desktop/proyectoicd/data/vector_intermedio.csv",N,limite_de_memoria))
    setwd("C:/Users/Manuel/Desktop/proyectoicd/data")
    file.remove("vector_intermedio.csv")
    
  }
  setwd("C:/Users/Manuel/Desktop/proyectoicd/reports")
  con3 = file("multiplicacionmv.csv", "r")
  line2 = readLines(con3, n = N*N)
  memoria_usada2 <-memoria_usada2 + object.size(line2)
  write.table(t(matrix(line2,ncol=N, byrow=TRUE)),file = "resultadomm.csv",col.names = F,row.names = F, quote = F,sep = ",")
  memoria_usada2 <-memoria_usada2 - object.size(line2)
  close(con3)  # Se cierra la conexión al archivo del vector por buena práctica
  memoria_usada2 <- 0  # Se vacia la memoria usada
  
  
}

