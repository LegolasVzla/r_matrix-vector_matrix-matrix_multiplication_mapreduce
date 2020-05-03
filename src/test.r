# Jose Prato 23185710 - Manuel Carrero 19821361

library(ProjectTemplate)

## Comando para establecer el directorio de trabajo
setwd("C:/Users/Prato/Desktop/ProyectoICD/proyectoicd/src")

## Cargo la función de multiplicación de Matriz x Vector
source("productmv.R")

## Cargo la función de multiplicación de Matriz x Matriz
source("productmm.R")

# matriz <- "C:/Users/Manuel/Desktop/proyectoicd/data/tblAkv3x3.csv"  # Matriz de 3x3
# matriz <- "C:/Users/Manuel/Desktop/proyectoicd/data/tblAkv10x10.csv"  # Matriz de 10x10
# matriz <- "C:/Users/Manuel/Desktop/proyectoicd/data/tblAkv10x10ident.csv"  # Matriz Identidad de 10x10
# vector <- "C:/Users/Manuel/Desktop/proyectoicd/data/tblxkv3.csv"  # Vector de 3
# vector <- "C:/Users/Manuel/Desktop/proyectoicd/data/tblxkv10.csv"  # Vector de 10

#--------------------------------------------------------------------------------------

matriz <- "C:/Users/Manuel/Desktop/proyectoicd/data/tblAkv10x10.csv"  # Matriz de 10x10
vector <- "C:/Users/Manuel/Desktop/proyectoicd/data/tblxkv10.csv"  # Vector de 10
N <- 10
limite_de_memoria <- 480

# m <- matrix(1:9,ncol=3, byrow=TRUE)
# v <- 1:3
# w <-  m %% v
# w

m <- matrix(1:100,ncol=10, byrow=TRUE)
v <- 1:10
w <-  m %% v
w

productmv(matriz,vector,N,limite_de_memoria)  # Función que realiza la multiplicación de matriz-vector

#--------------------------------------------------------------------------------------

matrizA <- "C:/Users/Manuel/Desktop/proyectoicd/data/tblAkv10x10.csv"
matrizB <- "C:/Users/Manuel/Desktop/proyectoicd/data/tblAkv10x10.csv"
N2 <- 10
limite_de_memoria <- 480

m <- matrix(1:100,ncol=10, byrow=TRUE)
w <-  m %% m
w

productmm(matrizA,matrizB,N2,limite_de_memoria)  # Función que realiza la multiplicación de matriz-matriz

