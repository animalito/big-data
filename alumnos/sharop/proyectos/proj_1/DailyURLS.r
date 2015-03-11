#!/usr/bin/Rscript
if("rvest" %in% rownames(installed.packages()) == FALSE) {install.packages("rvest")}
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
library(rvest)
library(plyr)
library(dplyr)
library(methods)

base_url <- "http://www.nuforc.org/webreports/"

# Para obtener una página (en este caso el index)
ufo_reports_index <- html(paste0(base_url, "ndxevent.html"))


# Obtenemos las URLs de las páginas por día
daily_urls <- paste0(base_url, ufo_reports_index %>%
                       html_nodes(xpath = "//*/td[1]/*/a[contains(@href, 'ndxe')]")  %>%
                       html_attr("href"))

daily_urls_ordered<-data_frame(daily_urls) %>%
  mutate(events = ufo_reports_index %>%
                  html_nodes(xpath = "//*/td[2]")%>%
                  html_text%>%
                  as.numeric)%>%
  arrange(events)


cat(daily_urls_ordered$daily_urls ,sep = '\n', file = stdout() )


