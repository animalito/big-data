#                                                        entrega 4 de marzo 2015 
#Gran Escala                                             Prof: Adolfo De Unánue 

library(rmeta)
library(rvest)

base_url <- "http://www.nuforc.org/webreports/"


# Para obtener una página (en este caso el index)
ufo_reports_index <- html(paste0(base_url, "ndxevent.html"))

# Puedo utilizar Xpath para navegar por el árbol
# En este caso en particular obtengo la seguna columna (el conteo de observaciones)
ufo_reports_index %>%
  html_nodes(xpath = "//*/td[2]")

# Obtenemos las URLs de las páginas por día
daily_urls <- paste0(base_url, ufo_reports %>%
                       html_nodes(xpath = "//*/td[1]/*/a[contains(@href, 'ndxe')]")  %>%
                       html_attr("href")
)



# Trae todas las tablas de la página en una lista (   ponemos la primera tabla de referencia y hacemos un loop )
n <- length(daily_urls)-1 # longitud 
tabla <- daily_urls[1] %>%
 html %>%
 html_nodes(xpath = '//*/table') %>%
 html_table(fill = TRUE)
tabla <- tabla[[1]]

# loop
for (i in 2:n){
  tabla1 <-  daily_urls[i] %>%
    html %>%
    html_nodes(xpath = '//*/table') %>%
    html_table(fill = TRUE)
  tabla <- rbind(tabla, tabla1[[1]])
}
str(tabla)
View(tabla)

#Lo pasamos a tablita 
write.table(tabla, file="~/proyecto/big-data/alumnos/AndyGT/proyecto_1/tablaUFO.txt",sep = "\t", col.names = TRUE)









