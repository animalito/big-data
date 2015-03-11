library(rvest)
library(dplyr)
base_url <- "http://www.nuforc.org/webreports/"

#obtengo el indice
ufo_reports_index <- html(paste0(base_url, "ndxevent.html"))

indice<-ufo_reports_index %>%
  html_nodes("font a") %>% html_attr("href")

#inicializo unas variables
resultados<-c(1,1)
tablas<-c(1,1)
j<-1
for (i in indice[1:861]){
  tablas[j] <- html(paste0(base_url, i))%>%
    html_nodes("table") %>% html_table(fill=TRUE)
  dias<-html(paste0(base_url, i))%>%
    html_nodes("font a") %>% html_attr("href")
  detalle<-c(1,1)
  l<-1
  for (k in dias){
  temp<-html(paste0(base_url, k))%>%
      html_nodes("tr+ tr font") %>% html_text()  
  if(length(temp)==0){detalle[l]<-"nothing"}else{detalle[l]<-temp}
  l<-l+1
 }
 resultados[j]<-cbind(tablas[[j]],detalle)
 j<-j+1
}


##siguiente parte del codigo
tbl_df(resultados[[1]])
?html_text()
class(ppp)
dim(ppp)
is.NA(ppp)
length(ppp)==0
ppp<-html("http://www.nuforc.org/webreports/116/S116518.html")%>%
  html_nodes("tr+ tr font") %>% html_text() 
