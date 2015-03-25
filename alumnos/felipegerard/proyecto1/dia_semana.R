#! /usr/bin/env Rscript

f <- file('stdin')
open(f)

while(length(line <- readLines(f, n = 1)) > 0){
#   day <- try(weekdays(as.Date(line)), silent = T)
#   if(class(day) == 'Date'){
#     write.table(day, file = stdout(), row.names = F, col.names = F)
#   }
  write.table(weekdays(as.Date(line)), file = stdout(), row.names = F, col.names = F)
}

close(f)