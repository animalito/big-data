# antes de este código en el pipeline
#cat ndxe201502.html | scrape -b -e '//td' | xml2json | jq '.' | grep '$t' | sed 's/^ *//;s/ *$//' | cut -c6- | /usr/bin/Rscript ../../../code/./toCsv.R
#! /bin/usr/Rscript
library(RJSONIO)
#setwd("~/ITAM/primavera15/projects/ufo")
con <- file('stdin','r')
file  <- readLines(con)
close(con)
data <- list()
k <- 1
for(i in 1:(length(file)/7)){
        registro <- list()
 for(j in 1:7){
    registro[[j]] <- file[k]
    k <- k + 1
 }
 data[[i]] <- registro
}
data.js <- toJSON(data)
write(data.js, "test.json")

#cat test.json | jq -c {'date: .[1][1], city: .[1][2], state: .[1][3], shape: .[1][4], duration: .[1][5],  description: .[1][6], posted: .[1][7]}'| json2csv -p -k date,city,state,shape,duration,description,posted | csvlook

