#!/usr/bin/env Rscript

# uso:  cat serie.csv | Rscript plot.r CA cool

library(methods)
library(ggplot2)

#options(echo=TRUE) # si se quiere ver el codigo en linea de comando
args <- commandArgs(trailingOnly = TRUE) # los argumentos

city <- as.character(args[1])
#start_date <- as.Date(args[2])
name <- args[2]
rm(args)

serie <- read.csv2(file("stdin"), header=T, sep=",")

serie2 <- serie[serie[,1]==city,]

# se crea imagen
png(paste(name,".png",sep=""))

# ploteamos
plot(serie2[,2],as.numeric(serie2[,3]), type='n')

#cerramos
dev.off()
