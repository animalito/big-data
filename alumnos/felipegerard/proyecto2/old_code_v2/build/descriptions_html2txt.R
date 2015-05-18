#! /usr/bin/env Rscript
library(rvest)
library(methods)
library(httr)

n <- as.integer(commandArgs(trailingOnly = TRUE)) # Leemos un entero como argumento (opcional). NO SIRVE
f <- file('stdin')
open(f)

while(length(lines <- readLines(f, n=1)) > 0){
#   print(lines)
  description <- html(lines) %>%
    html_nodes(css = 'tr:last-of-type') %>%
    .[[2]] %>%
    html_nodes(css = 'td font') %>%
    html_text()
 
  # Escribimos
  #print(description)
  write.table(description, file = stdout(), quote = FALSE, sep = '|', na = 'N/A', row.names = FALSE)
}

close(f)






