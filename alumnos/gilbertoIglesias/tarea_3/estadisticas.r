#!/usr/bin/env Rscript

#n <- as.string(commandArgs(trailingOnly = TRUE)) # Leemos un entero como argumento (opcional)

f <- file("stdin")

mydf <- read.table(f, header=FALSE, sep="|", na.strings="", fileEncoding="utf8")
#print (str(mydf))
#print (head(mydf))

mydf$factor = 0
mydf$factor <- ifelse(mydf$V2 == "hours" | mydf$V2 == "hour", 3600, mydf$factor)
mydf$factor <- ifelse(mydf$V2 == "minutes" | mydf$V2 == "minute", 60, mydf$factor)
mydf$factor <- ifelse(mydf$V2 == "seconds" | mydf$V2 == "second", 1, mydf$factor)

mydf$num_final = mydf$V1 * mydf$factor

print ("Media")
print (mean(mydf$num_final))
print ("Desv Std")
print (sd(mydf$num_final))
#print(head(mydf))
