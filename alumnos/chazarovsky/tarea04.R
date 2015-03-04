library(rvest)
base_url <- "http://data.gdeltproject.org/events/"
indice <- html(paste0(base_url,"index.html"))
nombres <- indice %>%
  html_nodes("a") %>%
  html_text()
write.table(nombres,"~/maestria/big-data/alumnos/chazarovsky/nombres.txt",col.names=F,row.names=F)
# DESCARGA.
for (i in nombres[4:801]){
  url <- paste0(base_url,i)
  destfile <- paste0("~/maestria/big-data/alumnos/chazarovsky/",i)
  download.file(url,destfile)
}

