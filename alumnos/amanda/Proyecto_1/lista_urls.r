#!/usr/bin/env Rscript

# Definimos url base
base_url <- "http://www.nuforc.org/webreports/"

# Obtenemos el índice
ufo_reports_index <- html(paste0(base_url, "ndxevent.html"))

# Obtenemos las URLs de las páginas por día
daily_urls <- paste0(base_url, ufo_reports_index %>%
                       html_nodes(xpath = "//*/td[1]/*/a[contains(@href, 'ndxe')]")  %>%
                       html_attr("href"))

# Guardamos la lista de URLs
write.table(daily_urls, "C:/Users/Amanda/Documents/archivos_gran_escala/UFO_urls.txt")
