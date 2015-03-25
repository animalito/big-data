library(rvest)
setwd('/Users/Felipe/big-data/alumnos/FelipeGerard/proyecto1')

base_url <- 'http://www.nuforc.org/'
index_url <- 'http://www.nuforc.org/webreports/ndxevent.html'
webreports_url <- 'http://www.nuforc.org/webreports/'
index <- html(index_url)

data_urls <- index %>%
  html_nodes(css = 'a') %>%
  html_attr('href') %>%
  grep(pattern = 'ndxe', value=T)
data_urls <- paste0(webreports_url, data_urls)

#write(data_urls, 'data_urls')






































