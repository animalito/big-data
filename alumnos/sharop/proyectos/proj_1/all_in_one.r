#!/usr/bin/Rscript
if("rvest" %in% rownames(installed.packages()) == FALSE) {install.packages("rvest")}
if("plyr" %in% rownames(installed.packages()) == FALSE) {install.packages("plyr")}
if("magrittr" %in% rownames(installed.packages()) == FALSE) {install.packages("magrittr")}

library(rvest)
library(plyr)
library(dplyr)
library(magrittr)
library(methods)
#1.Obtenemos URL ordenadas de mayor a menor conteo de eventos por pagina.
#2. si sobrepasan los 50 elementos por pagina lo dividimos y enviamos con parallel

base_url <- "http://www.nuforc.org/webreports/"

# Para obtener una página (en este caso el index)
ufo_reports_index <- html(paste0(base_url, "ndxevent.html"))
daily_urls <- paste0(base_url, ufo_reports_index %>%
                       html_nodes(xpath = "//*/td[1]/*/a[contains(@href, 'ndxe')]")  %>%
                       html_attr("href"))

daily_urls_ordered<-data_frame(daily_urls) %>%
  mutate(events = ufo_reports_index %>%
           html_nodes(xpath = "//*/td[2]")%>%
           html_text%>%
           as.numeric)%>%
  arrange(desc(events))


jnTable<-function(urlUFO)
{
  current_page <- html(urlUFO)
  table <- do.call(rbind.data.frame,  current_page  %>%
    html_nodes(xpath = '//*/table[1]') %>%
    html_table(fill = TRUE))
  
  reports_url <- paste0(base_url, current_page %>%
                          html_nodes(xpath = '//*/td[1]/*/a') %>%
                          html_attr('href'))
  
  ufo_w_url <- table%>%
                mutate(url_summary=unlist(reports_url))
  ufo_w_url
}

unbox<-function(idx){
  param<-paste(unlist(temptab[idx,]),collapse = '|')
  param
}


#param <- cat(unlist(temptab[1,]),sep='|',file=stdout() )
#param<-paste(unlist(temptab[1,]),collapse = '|')

for (idx in 1:nrow(daily_urls_ordered)){
  if (daily_urls_ordered$events[idx] >100){
    temptab<-jnTable(daily_urls_ordered$daily_urls[idx],1)
    paramlist <- rdply(nrow(temptab),unbox)
    for(idy in 1:length(paramlist)){
      system("parallel  --sshlogin : '(hostname; ./testa.r {}|paste -sd:)' ",input = paramlist[idy][[1]]  )
    }
  }else
  {
    
  }
}
