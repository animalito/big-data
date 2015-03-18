library(rvest)
base_url <- "http://data.gdeltproject.org/events/"
gdelt.files <- html(paste0(base_url,"index.html"))
files.names <- gdelt.files %>%
  html_nodes("a") %>%
  html_text()
write.table(files.names,"~/maestria/big-data/alumnos/chazarovsky/files.names.txt",col.names=F,row.names=F)
# DESCARGA.
for (i in files.names[4:801]){
  url <- paste0(base_url,i)
  destfile <- paste0("~/maestria/big-data/alumnos/chazarovsky/",i)
  download.file(url,destfile)
}

