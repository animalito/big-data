#install.packages("rvest",lib="/usr/lib/R/library",repos="http://cran.rstudio.com/")
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

n <- length(daily_urls)

tabla <- tabla[[1]]

#2:(length(daily_urls)-1)
for (i in 2:(length(daily_urls)-1)){
  tabla  <-  daily_urls[i] %>%
    html %>%
    html_nodes(xpath = '//*/table') %>%
    html_table()
  a<-rbind(a,tabla[[1]])
  write.table(a, file="~/tabla.txt",sep = "\t", col.names = TRUE)
}

#
# #Descargas la segunda seccion de cada registro. donde vienen los comentarios.
# #2:(length(daily_urls)-1)
# # prueba con algunos registros... sustituir 715:720 por el renglon de arriba
# for (i in 715:720){
#       reports_url <- paste0(base_url, daily_urls[i] %>%
#                           html %>%
#                           html_nodes(xpath = '//*/td[1]/*/a') %>%
#                           html_attr('href')
#   )
#     for (i in 1:length(reports_url)){
#       report <- reports_url[i] %>%
#         html %>%
#         #tr:nth-child(1) td
#         html_nodes('td') %>%
#         html_text
#
#       vector <- c(vector,report)
#   }
#   vector
# }
# vector
# write.table(t(vector),"vector.txt",row.names=F,col.names=F)

#saveRDS(vector,"vector.rds")
