library(rvest)

base_url <- "http://data.gdeltproject.org/events/"

gdelt.files <- html(paste0(base_url,"index.html"))

files.names <- gdelt.files %>%
    html_nodes("a") %>%
    html_text()

write.table(files.names,"alumnos/jtmancilla/gdelt_file/urls/files.names.txt",col.names=F,row.names=F)


# DESCARGA.
for (i in files.names[4:801]){
    url <- paste0(base_url,i)
    destfile <- paste0("~/dropbox/documents/itam/primavera2015/big-data/alumnos/jtmancilla/gdelt_file/",i)
    download.file(url,destfile)
}





