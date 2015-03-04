library(rvest)

base_url <- "http://data.gdeltproject.org/events/"

# Para obtener una página (en este caso el index)
gdelt_data_index <- html(paste0(base_url, "index.html"))

# Puedo utilizar Xpath para navegar por el árbol
# En este caso en particular obtengo la seguna columna (el conteo de observaciones)
# http://data.gdeltproject.org/events/20150217.export.CSV.zip
lista1 <- gdelt_data_index %>%
  html_nodes(xpath = "//li//a") %>%
  html_text()
lista_gdelt_data <- lista1[4:(length(lista1)-1)]

# Obtenemos las URLs de las páginas por día
data_urls <- paste0(base_url, lista_gdelt_data)

# Guardamos el resultado en un archivo de texto
# write.table(data_urls,
#             file = '/Users/Felipe/big-data/alumnos/FelipeGerard/GDELT/urls_GDELT.tsv')





