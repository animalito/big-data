#!/usr/bin/env Rscript

# Leemos parametros 
args <- commandArgs()
print(args)

name <- args[grep('.html$', args)]
nname <- args[grep('.csv$', args)]

# Libreria methods es loadeada por bug
library(rvest)
library(methods)

# transformamos y guardamos
tabla <- data.frame(html_table(html(x=name), fill=TRUE))
write.csv(tabla, file=nname, row.names=F)

