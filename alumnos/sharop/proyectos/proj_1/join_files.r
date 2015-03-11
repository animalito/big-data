#!/usr/bin/Rscript
library(methods)

path<-"~/out"
files<-list.files(path, pattern = ".tsv", full.names = TRUE)
tables<-lapply(files, read.delim, sep='\t', header=TRUE)
table<-do.call(rbind,tables)

file_base<-"part_frame"
now<-format(Sys.time(), "%b%d%H%M%OS3")
outputfile <- paste(file_base, "-",now,"-output.tsv", sep="")

write.table(table, file=paste0("~/out/",outputfile,collapse = ''), sep = "\t", col.names = TRUE)

cat("Archivo creado: ",outputfile, "\n")
