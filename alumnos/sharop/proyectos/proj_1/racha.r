library(magrittr)
library(tidyr)
library(plyr)
library(dplyr)
nc_c<-noc_time[!is.na(noc_time$STATE),]
nc_c<-nc_c[nc_c$STATE!="", ]
nc_c<-nc_c[nc_c$STATE!="\\", ]
names(nc_c)


ufo_time <- nc_c %>%  
  mutate(DATE = as.Date(DATE,format='%m/%d/%y'))
  

##lag(ufo_time, k =1)


alm <-ufo_time%>%
  group_by(STATE,DATE)%>%
  arrange(STATE, DATE)%>%
  summarise(avistamiento =n())%>%
  mutate(f = avistamiento/sum(avistamiento),
         p = lag(DATE),
         d = (DATE -p))

secuencia_acumulado <- sequence(rle(as.character(alm$DATE))$lengths)



backf <- alm[order(secuencia_acumulado), ] %>%
  group_by(STATE)
top_n(backf, n=1)
