library(methods)
library(rvest)
base_url <- "http://www.nuforc.org/webreports/"

# Para obtener una página (en este caso el index)
ufo_reports_index <- html(paste0(base_url, "ndxevent.html"))

# Obtenemos las URLs de las páginas por día
daily_urls <- paste0(base_url, ufo_reports_index %>%
                       html_nodes(xpath = "//*/td[1]/*/a[contains(@href, 'ndxe')]")  %>%
                       html_attr("href")
)

tabla <- daily_urls[1] %>%
  html %>%
  html_nodes(xpath = '//*/table') %>%
  html_table()

a<-tabla[[1]]
for (i in 2:(length(daily_urls)-1)){
  tabla  <-  daily_urls[i] %>%
    html %>%
    html_nodes(xpath = '//*/table') %>%
    html_table()
  a<-rbind(a,tabla[[1]])
  write.table(a, file="/home/itam/proyectos/alumnos/aaronsapa1/proyecto1/ufo.txt",sep = "\t", col.names = TRUE)
}