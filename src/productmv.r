# Jose Prato 23185710 - Manuel Carrero 19821361

productmv <- function(matriz,vector,N,limite_de_memoria){
  #  Se asignan las cantidades de memoria RAM disponibles a los elementos que se usarán, asumiendo que cada 
  #  elemento pesa como mínimo 48 bytes y una fila 96

# Consideraciones de memoria    
#   size_acumulador_mult_suma <- 48  # Para mayor eficiencia, se asigna mayor memoria al vector de los elementos de la matriz que se vayan leyendo
#   size_line_matriz <- 96 # Límite de memoria asignado a la lectura de una fila del archivo de la matriz
#   size_line_vector <- 96 # Límite de memoria asignado a la lectura de una fila del archivo del vector
#   size_cont_filas <-48  # Límite de memoria asignado al cont_filas
  setwd("C:/Users/Manuel/Desktop/proyectoicd/reports")  # Se establece el directorio para el archivo de salida
  
   memoria_usada <- 0
   memoria_usada <- memoria_usada + object.size(memoria_usada)
  
  #-------------------------------------------------------------------------- 
  #options(warn= -1)  # Desactivar Warning, para volverlos a activar options(warn= 0)

#  file.remove("resultado_multiplicaciónmv.csv")
  
  acumulador_mult_suma <- 0  
  memoria_usada <- memoria_usada + object.size(acumulador_mult_suma)
  
  cont_filas <- as.integer(1)  # Contador que permitirá saber en qué fila de la matriz estás
  memoria_usada <- memoria_usada + object.size(cont_filas)
  
  for(k in 1:N){  # Ciclo para recorrer hasta el final del archivo
    
    con = file(matriz, "r")  # Se establece la conexión con el archivo de la matriz
    #--------------------------------------------------------------------------    
    # Se asume que cabe al menos el primer elemento i,j de la matriz, dado que cada elemento pesa 48 bytes
    
    if(cont_filas > 1){  # Caso 2: Búsqueda de la fila i-ésima
 #     cat("Estoy buscando la fila: ",cont_filas,"de la matriz\n")
      z <- 0
      memoria_usada <- memoria_usada + object.size(z)
      i_m <- ""
      while((i_m != cont_filas) && (z < N)){ # for(z in 1:n){  # Recorrer hasta encontrar la siguiente fila que corresponda leer. Nota: ésto se evitaría si se tuviera un apuntador al fichero, para comenzar desde la fila que correspondiese y no desde la primera siempre.

        #----------------Lectura del primer elemento de la matriz---------------------  
        # Se asume que se tiene memoria para leer la primera fila
        line = readLines(con, n = 1)  # Se toma la fila de la matriz
        #size_line_matriz <- object.size(line)  # Se obtiene el peso de esa fila
        memoria_usada <- memoria_usada + object.size(line)   # 96 bytes...
        line <- strsplit(line, split = ",")
        i_m <- as.integer(line[[1]][[1]])  # Posición i de la matriz
        memoria_usada <- memoria_usada + object.size(i_m)
        #      j_m <- x[[1]][[2]]  # Posición j de la matriz
        v_m <- as.numeric(line[[1]][[3]])  # Valor de la matriz
        memoria_usada <- memoria_usada + object.size(v_m)
#        cat(i_m," ",v_m,"\n")
        memoria_usada <- memoria_usada - object.size(line)
        #--------------------------------------------------------------------------    
        if(i_m == cont_filas){  # Encontré la fila que corresponde leer, es decir la siguiente columna de la fila que se está leyendo en la matriz
#          cat("Son iguales im y cont filas!\n")
          if(memoria_usada < limite_de_memoria){  # Si se cumple, quiere decir que se pueden añadir elementos al vector matriz

            #----------------Lectura del primer elemento del vector-----------------------    
            con2 = file(vector, "r") # Se establece la conexión con el archivo del vector             
            line2 = readLines(con2, n = 1)  # Se toma la fila del vector
            memoria_usada <- memoria_usada + object.size(line2)
            
            line2 <- strsplit(line2, split = ",")
            #      i_v <- as.integer(y[[1]][[1]])  # Posición i del vector
            v_v <- as.numeric(line2[[1]][[2]])  # Valor del vector
            memoria_usada <-memoria_usada + object.size(v_v)  # 96 + 48 = 144 bytes
            memoria_usada <-memoria_usada - object.size(line2)
#             cat(v_v,"\n")
            #       Sys.sleep(2)
            
            #----------------Multiplicación y Suma de los elementos leídos----------------
            acumulador_mult_suma <- acumulador_mult_suma + (v_m * v_v)
            memoria_usada <- memoria_usada + object.size(acumulador_mult_suma)  # 144 + 48 = 192 bytes
            memoria_usada <- memoria_usada - (object.size(v_m) + object.size(v_v))
 #           cat("Multiplico el ",v_m,"con el ",v_v,"\n")
          }
        }
        z <- z + 1
      }
      memoria_usada <- memoria_usada - object.size(z)
      
    }else{  # Caso 1: 1ra Fila
      #----------------Lectura del primer elemento de la matriz---------------------  
      # Se asume que se tiene memoria para leer la primera fila
      line = readLines(con, n = 1)  # Se toma la fila de la matriz
      #size_line_matriz <- object.size(line)  # Se obtiene el peso de esa fila
      memoria_usada <- memoria_usada + object.size(line)   # 96 bytes...
#      cat("Caso 1ra Fila",line,"\n")
      
      line <- strsplit(line, split = ",")
      i_m <- as.integer(line[[1]][[1]])  # Posición i de la matriz
      memoria_usada <- memoria_usada + object.size(i_m)
      
#      j_m <- x[[1]][[2]]  # Posición j de la matriz
      v_m <- as.numeric(line[[1]][[3]])  # Valor de la matriz
      memoria_usada <- memoria_usada + object.size(v_m)
#       cat(i_m," ",v_m,"\n")
      memoria_usada <- memoria_usada - object.size(line)
      
      #----------------Lectura del primer elemento del vector-----------------------    
      con2 = file(vector, "r") # Se establece la conexión con el archivo del vector             
      line2 = readLines(con2, n = 1)  # Se toma la fila del vector
      memoria_usada <- memoria_usada + object.size(line2)
            
      line2 <- strsplit(line2, split = ",")
#      i_v <- as.integer(y[[1]][[1]])  # Posición i del vector
      v_v <- as.numeric(line2[[1]][[2]])  # Valor del vector
      memoria_usada <-memoria_usada + object.size(v_v)  # 96 + 48 = 144 bytes
      memoria_usada <-memoria_usada - object.size(line2)
#      cat(v_v,"\n")
      #       Sys.sleep(2)
      
# Nota: La lectura del elemento de la matriz y del elemento del vector, se podría paralelizar para optimizar
# el algoritmo, mediante el paquete parallel.r: https://stat.ethz.ch/R-manual/R-devel/library/parallel/doc/parallel.pdf
# library(parallel)
      
      #----------------Multiplicación y Suma de los elementos leídos----------------
      acumulador_mult_suma <- acumulador_mult_suma + (v_m * v_v)
      memoria_usada <- memoria_usada + object.size(acumulador_mult_suma)  # 144 + 48 = 192 bytes
      memoria_usada <- memoria_usada - (object.size(v_m) + object.size(v_v))
 #     cat("Multiplico el ",v_m,"con el ",v_v,"\n")
    }    
    i <- 0
    memoria_usada <- memoria_usada + object.size(i)
    while(i < ((N*N) - cont_filas)){  # Ciclo para recorrer el resto de las filas (columnas restantes de la fila que se está leyendo). i in 2 = para que comience en 1, ya que i in 1 inicia en 0, ésto para que lea la siguiente fila a la que leyó anteriormente (1ra fila o fila i-ésima caso 2). Se decrementará a medida que el cont_filas aumente.

      #----------------Lectura del primer elemento de la matriz---------------------  
      # Se asume que se tiene memoria para leer la primera fila
      line = readLines(con, n = 1)  # Se toma la fila de la matriz
      #size_line_matriz <- object.size(line)  # Se obtiene el peso de esa fila
      memoria_usada <- memoria_usada + object.size(line)   # 96 bytes...
#      cat(line,"\n")
      
      line <- strsplit(line, split = ",")
      i_m <- as.integer(line[[1]][[1]])  # Posición i de la matriz
      memoria_usada <- memoria_usada + object.size(i_m)
      
      #      j_m <- x[[1]][[2]]  # Posición j de la matriz
      v_m <- as.numeric(line[[1]][[3]])  # Valor de la matriz
      memoria_usada <- memoria_usada + object.size(v_m)
#      cat(i_m," ",v_m,"\n")
      memoria_usada <- memoria_usada - object.size(line)
      #--------------------------------------------------------------------------     
      if(cont_filas == i_m) {  
 #       cat("Entre aca\n")
        if(memoria_usada < limite_de_memoria){  # Si se cumple, quiere decir que se pueden añadir elementos al vector matriz

          #----------------Lectura del primer elemento del vector-----------------------    
          line2 = readLines(con2, n = 1)  # Se toma la fila del vector
          memoria_usada <- memoria_usada + object.size(line2)
          
          line2 <- strsplit(line2, split = ",")
          #      i_v <- as.integer(y[[1]][[1]])  # Posición i del vector
          v_v <- as.numeric(line2[[1]][[2]])  # Valor del vector
          memoria_usada <-memoria_usada + object.size(v_v)  # 96 + 48 = 144 bytes
          memoria_usada <-memoria_usada - object.size(line2)
#          cat(v_v,"\n")
          #       Sys.sleep(2)

          #----------------Multiplicación y Suma de los elementos leídos----------------
          acumulador_mult_suma <- acumulador_mult_suma + (v_m * v_v)
          memoria_usada <- memoria_usada + object.size(acumulador_mult_suma)  # 144 + 48 = 192 bytes
          memoria_usada <- memoria_usada - (object.size(v_m) + object.size(v_v))
#          cat("Multiplico el ",v_m,"con el ",v_v,"\n")
          
       }
      }
      i <- i + 1
    }
    memoria_usada <- memoria_usada - object.size(i)
 
    cont_filas <- cont_filas + 1  # Incremento para recorrer ahora la siguiente fila de la matriz
#    cat("cont_filas",cont_filas,"\n")
    cat(acumulador_mult_suma,file="multiplicacionmv.csv",sep="\n", append = TRUE)  # Se escribe en el archivo de salida la multiplicación

    acumulador_mult_suma <- 0
       
    close(con)  # Se cierra la conexión al archivo de la matriz para empezar otra vez desde el inicio
    close(con2)  # Se cierra la conexión al archivo del vector para empezar otra vez desde el inicio
    
  }
  #close(con)  # Se cierra la conexión al archivo de la matriz pot buena práctica
  #close(con2)  # Se cierra la conexión al archivo del vector por buena práctica

  memoria_usada <- 0  # Se vacia la memoria usada
}
