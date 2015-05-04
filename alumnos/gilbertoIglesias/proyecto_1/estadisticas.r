#!/usr/bin/env Rscript 

library("ggplot2")

df <- data.frame(X= numeric(0), Date= numeric(0), Num= numeric(0))

f <- file("stdin")

open(f)
i = 1
while(length(line <- readLines(f, n = 1) ) > 0) {
	s <- strsplit(line, ',')
	df[i, ] <- c(1, s[[1]][2], s[[1]][1])
	i <- i + 1
	
}

close(f)

ggplot(df, aes(Date, Num)) +
	geom_line(aes(colour =  X, group = X )) + 
	theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size= 1))
