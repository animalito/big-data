#!/usr/bin/Rscript

argumentos<- commandArgs(TRUE)
library(methods)

#options(echo = TRUE)
#paste0(argumentos, sep='')

#cat("numero de argumentos:",length(argumentos))
cat(paste0(cat(argumentos, file = stdout(), sep = ' ',append=TRUE),cat("\n")),file=stdout())
