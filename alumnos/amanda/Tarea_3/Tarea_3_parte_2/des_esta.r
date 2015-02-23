#!/usr/bin/env Rscript

f <- file("stdin")

open(f)

datos <- read.table(f) 
media <- round(mean(datos$V1), 0)
minimo <- min(datos$V1)
maximo <- max(datos$V1)
mediana <- median(datos$V1)
desviacion <- round(sd(datos$V1), 0)
varianza <- round(var(datos$V1), 0)

print(paste("Media = ", media, sep = " "))
print(paste("Maximo = ", maximo, sep = " ")) 
print(paste("Minimo = ", minimo, sep = " "))
print(paste("Mediana = ", mediana, sep = " "))
print(paste("Desviacion estandar = ", desviacion, sep = " "))
print(paste("Varianza = ", varianza, sep = " "))

close(f)