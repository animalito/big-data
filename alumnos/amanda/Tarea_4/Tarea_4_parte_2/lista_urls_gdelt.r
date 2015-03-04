
#install.packages('rvest')
library(rvest)

base_url <- "http://data.gdeltproject.org/events/"

# Para obtener el index
gdelt_index <- html(paste0(base_url, "index.html"))

# Obtenemos las URLs de las páginas por dí­a
daily_urls <- paste0(gdelt_index  %>%
      html_nodes(xpath = "// /a[contains(@href, 'export')]")  %>%
      html_attr("href")
    )

# Completamos las URLS
daily_urls <- paste0(base_url, daily_urls)

# Guardando la lista
write.table(daily_urls, "C:/Users/Amanda/Documents/archivos_gran_escala/Tarea_4/lista_urls_gdelt.txt")
