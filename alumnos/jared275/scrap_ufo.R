
library(methods)
library(rvest)

ufo_data <- html("http://www.nuforc.org/webreports/ndxevent.html")

archivos<-ufo_data%>%
  html_nodes("a") %>%
  html_attr("href")

archivos_2<-paste0("http://www.nuforc.org/webreports/",archivos[2:862])


direccion <- html(archivos_2[1])
tabla<-direccion%>%
  html_nodes(xpath='//*/table') %>%
  html_table()
a<-tabla[[1]]


for(i in 2:length(archivos_2)){  
  direccion <- html(archivos_2[i])
  tabla<-direccion%>%
    html_nodes(xpath='//*/table') %>%
    html_table()
  
  a<-rbind(a,tabla[[1]])
}

ufo_base<-data.frame(a)

write.table(a, file="/home/jared/big-data/alumnos/jared275/base_ufo.txt",sep = "\t", col.names = TRUE)
