library(rvest)
library(rmeta)

base_url <- "http://www.nuforc.org/webreports/"

# Para obtener una página (en este caso el index)
ufo_reports_index <- html(paste0(base_url, "ndxevent.html"))

# Puedo utilizar Xpath para navegar por el árbol
# En este caso en particular obtengo la seguna columna (el conteo de observaciones)
ufo_reports <- ufo_reports_index %>%
  html_nodes(xpath = "//*/td[2]")

# Obtenemos las URLs de las páginas por día
daily_urls <- paste0(base_url, ufo_reports_index %>%
              html_nodes(xpath = "//*/td[1]/*/a[contains(@href, 'ndxe')]")  %>%
              html_attr("href"))

#longitud de los "daily_urls"
n<-length(daily_urls)-1 

#dejamos como tabla de referencia a la primera
tabla_master <- daily_urls[1] %>%
  html %>%
  html_nodes(xpath = '//*/table') %>%
  html_table(fill = TRUE)
tabla_master <- tabla_master[[1]]

#loop para bajar todos los archivos
for (i in 2:n){
    tabla <-  daily_urls[i] %>%
    html %>%
    html_nodes(xpath = '//*/table') %>%
    html_table(fill = TRUE)
    tabla_master <- rbind(tabla_master, tabla[[1]])
}
str(tabla_master)
View(tabla_master)

#Escribir los datos en una tabla
write.table(tabla, file="/Users/AVL/Desktop/Andres/ESCUELA/ITAM/CLASES/2do semestre/Métodos a gran escala/andreslechuga/proyectos/proyecto1/tablaUFO.txt",sep = "\t", col.names = TRUE)





