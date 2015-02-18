#!/usr/bin/env Rscript


f <- file("stdin")

class(f)

vec <- read.table(f, header=F)

summary(vec)

sd(vec$V1)

