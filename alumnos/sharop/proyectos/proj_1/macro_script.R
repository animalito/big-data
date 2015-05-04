# install.packages('rvest')
library(rvest)
library(plyr)
library(dplyr)

base_url <- "http://www.nuforc.org/webreports/"

# Para obtener una página (en este caso el index)
ufo_reports_index <- html(paste0(base_url, "ndxevent.html"))

# Puedo utilizar Xpath para navegar por el árbol
# En este caso en particular obtengo la seguna columna (el conteo de observaciones)
ufo_reports_index %>%
  html_nodes(xpath = "//*/td[2]")%>%
  html_text%>%
  as.numeric%>%
  sum
  
# Obtenemos las URLs de las páginas por día
daily_urls <- paste0(base_url, ufo_reports_index %>%
                       html_nodes(xpath = "//*/td[1]/*/a[contains(@href, 'ndxe')]")  %>%
                       html_attr("href"))

# Trae todas las tablas de la página en una lista
table <- do.call(rbind.data.frame, daily_urls[1] %>%
                   html  %>%
                   html_table (fill = TRUE))

reports_url <- paste0(base_url, daily_urls[1] %>%
                        html %>%
                        html_nodes(xpath = '//*/td[1]/*/a') %>%
                        html_attr('href')
)

get_Summary<-function (url)
{
  summary_comp<-url %>%
    html %>%
    html_nodes(xpath='//*/tr[2]') %>%
    html_text
}

table_u<-table%>%
  mutate(Summary=unlist(lapply(reports_url ,get_Summary)))



# 1. Extraemos las url de todas la paginas.
# 2. Por cada pagina extraemos la tabla y summary completo y lo enviamos a un dataframe
# 3. Unimos ese data frame por el bloque de paginas creado
# 4. Se almacena en un solo data frame.