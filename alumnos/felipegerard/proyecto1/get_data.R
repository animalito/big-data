#! /usr/bin/env Rscript
library(rvest)
library(methods)
base_url <- 'http://www.nuforc.org/'
webreports_url <- paste0(base_url,'/webreports/')

n <- as.integer(commandArgs(trailingOnly = TRUE)) # Leemos un entero como argumento (opcional). NO SIRVE
f <- file('stdin')
open(f)

while(length(lines <- readLines(f, n=1)) > 0){
  ruta <- paste0(webreports_url, lines)
  x <- html(ruta)
  x <- html_nodes(x, css='table') %>%
    html_table(header = T) %>%
    as.data.frame()
  write.table(x, file = stdout())
}

close(f)










