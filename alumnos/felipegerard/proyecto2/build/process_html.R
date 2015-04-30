#! /usr/bin/env Rscript
library(rvest)
library(methods)
library(httr)
#setwd('/Users/Felipe/big-data/alumnos/felipegerard/proyecto2')
base_url <- 'http://www.nuforc.org/'
webreports_url <- paste0(base_url,'webreports/')


n <- as.integer(commandArgs(trailingOnly = TRUE)) # Leemos un entero como argumento (opcional). NO SIRVE
f <- file('stdin')
open(f)

while(length(lines <- readLines(f, n=1)) > 0){
  # Base
  #ruta <- paste0(webreports_url, lines)
  # ruta <- "http://www.nuforc.org/webreports/ndxe201502.html"
  # ruta <- "/Users/Felipe/big-data/alumnos/felipegerard/proyecto2/html/ndxe.ufo_html"
  ruta <- lines
  #print(ruta)
  raw <- html(ruta)
  x <- html_nodes(raw, css='table') %>%
    html_table(header = T) %>%
    as.data.frame()
  # Descripciones
  desc_urls <- raw %>%
    html_nodes(css = 'a') %>%
    html_attr('href') %>%
    grep(pattern = 'html', value=T)
  desc_urls <- paste0(webreports_url, desc_urls)
  x$Description_URL <- desc_urls

  # Escribimos
  write.table(x, file = stdout(), quote = FALSE, sep = '|', row.names = FALSE)
}

close(f)






