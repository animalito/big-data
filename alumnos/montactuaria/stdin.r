#!/usr/bin/env Rscript

f <- file("stdin")

open(f)

while(length(lines <- readLines(f, n = 1)) > 0) {
  lines <- gsub("minute|min|minutes","m",lines,ignore.case=TRUE)
  lines <- gsub("second|seconds|s", "s", lines,ignore.case=TRUE)
  lines <- gsub("hour|h|hours","h",lines,ignore.case=TRUE)
  lines <- gsub("[^msh0-9]","",lines)
  write(lines, stderr())
}

close(f)