#!/usr/bin/Rscript
if("rvest" %in% rownames(installed.packages()) == FALSE) {install.packages("rvest")}
if("plyr" %in% rownames(installed.packages()) == FALSE) {install.packages("plyr")}
if("magrittr" %in% rownames(installed.packages()) == FALSE) {install.packages("magrittr")}

library(rvest)
library(plyr)
library(magrittr)
library(methods)
 
argumentos<-commandArgs(TRUE)
base_url <- "http://www.nuforc.org/webreports/"

#cat(args)

####Funciones
get_Summary<-function (url)
{
  summary_comp<-url %>%
    html %>%
    html_nodes(xpath='//*/tr[2]') %>%
    html_text
}

####End Funciones
table_a<-{}

for(iArgs in 1:length(argumentos))
{
  current_page <- html(argumentos[iArgs])
  # Trae la tabla de la página en una lista
  table <- current_page  %>%
    html_nodes(xpath = '//*/table[1]') %>%
    html_table(fill = TRUE)
  
  #reports_url <- paste0(base_url, current_page %>%
  #                        html_nodes(xpath = '//*/td[1]/*/a') %>%
  #                        html_attr('href'))
  
  #table_u<-table[[1]]%>%
  #          mutate(Summary=unlist(lapply(reports_url ,get_Summary)))
  
  table_a<-rbind(table_a,table[[1]])
  
}
file_base<-"ufoframe"
now<-format(Sys.time(), "%b%d%H%M%OS3")
outputfile <- paste(file_base, "-",now,"-output.tsv", sep="")

write.table(table_a, file=paste0("~/out/",outputfile,collapse = ''), sep = "\t", col.names = TRUE)

cat("Archivo creado: ",outputfile, "\n")
# 1. Extraemos las url de todas la paginas.
# 2. Por cada pagina extraemos la tabla y summary completo y lo enviamos a un dataframe
# 3. Unimos ese data frame por el bloque de paginas creado
# 4. Se almacena en un solo data frame.