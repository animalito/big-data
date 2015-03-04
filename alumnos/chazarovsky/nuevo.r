#!/usr/bin/env Rscript
f <- file("stdin")
open(f)
a=1
b=c(1,1)
while(length(line <- readLines(f,n=1)) > 0) {
b[a]=as.numeric(line)
a=a+1
}
summary(b)
close(f)