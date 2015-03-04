#!/usr/bin/env Rscript

library(rvest)

base_url <- "http://www.nuforc.org/webreports/"

# Para obtener una página (en este caso el index)
ufo_reports_index <- html(paste0(base_url, "ndxevent.html"))

# Puedo utilizar Xpath para navegar por el árbol
# En este caso en particular obtengo la seguna columna (el conteo de observaciones)
ufo_reports_index %>%
  html_nodes(xpath = "//*/td[2]")

# Obtenemos las URLs de las páginas por día
daily_urls <- paste0(base_url, ufo_reports_index %>%
                       html_nodes(xpath = "//*/td[1]/*/a[contains(@href, 'ndxe')]")  %>%
                       html_attr("href")
)



tabla <-daily_urls[1] %>%
  html %>%
  html_nodes(xpath = '//*/table') %>%
  html_table()

a<-tabla[[1]]

n<-length(daily_urls)


for (i in 2:n){
  tabla  <-  daily_urls[i] %>%
    html %>%
    html_nodes(xpath = '//*/table') %>%
    html_table()
  a<-rbind(a,tabla[[1]])
  write.table(a, file="~/CGM/UFO/tabla.txt",sep = "\t", col.names = TRUE)
}





