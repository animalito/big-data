library(rvest)

base_url <- "http://www.nuforc.org/webreports/"

# Para obtener una página (en este caso el index)
ufo_reports_index <- html(paste0(base_url, "ndxevent.html"))

# Obtenemos las URLs de las páginas por día
daily_urls <- paste0(base_url, ufo_reports_index %>%
                         html_nodes(xpath = "//*/td[1]/*/a[contains(@href, 'ndxe')]")  %>%
                         html_attr("href")
)

# eliminamos el ultimo que no tiene fecha especificada
daily_urls <- daily_urls[which(daily_urls!="http://www.nuforc.org/webreports/ndxe.html")]

write(daily_urls, file='data/urls.txt')
