---
title: 'Proyecto 1: Gran Escala'
author: "Carlos González"
date: "Saturday, February 28, 2015"
output: ioslides_presentation
---

## Proyecto 1: Descarga y análisis base UFO.
script de R para el scrapping

```r
library(methods)
library(rvest)
base_url <- "http://www.nuforc.org/webreports/"

ufo_reports_index <- html(paste0(base_url, "ndxevent.html"))
daily_urls <- paste0(base_url, ufo_reports_index %>%
                       html_nodes(xpath = 
                       "//*/td[1]/*/a[contains(@href, 'ndxe')]")  %>%
                       html_attr("href"))
```

## Proyecto 1: Descarga y análisis base UFO.


```r
tabla <- daily_urls[1] %>%
  html %>%
  html_nodes(xpath = '//*/table') %>%
  html_table()
##Se crea el acumulado con el primer día de avistamientos
acumulado<-tabla[[1]]  ###Se pasa a modo de tabla
## Se descargan los archivos menos el último 
for (i in 2:(length(daily_urls)-1)){
  tabla  <-  daily_urls[i] %>%
    html %>%
    html_nodes(xpath = '//*/table') %>%
    html_table()
  a<-rbind(a,tabla[[1]])
  write.table(a, file="~/tabla.txt",sep = "\t", col.names = TRUE)
}
```

##
-- La línea de código para la distribución en las máquinas de amazon.
Después de tener las instancias configuradas en AWS. 
Se instala R de la misma forma que se instaló "parallel":

```r
parallel --nonall --slf instancias 
```
                        "sudo apt-get install -y parallel"        
                        
-- Para R:

                        "sudo add-apt-repository ppa:marutter/rrutter"
                        "sudo apt-get update"
                        "sudo apt-get install r-base r-base-dev"     
                        
##
                        
Para la descarga de archivos:


```r
parallel --nonall Rscript script_Rdown_UFO.R 
--slf instancias "./script_Rdown_UFO.R"
```

- Fuente:

<http://askubuntu.com/questions/496788/you-have-held-broken-package-while-trying-to-install-r>


## Preguntas
Se observa que se tienen comillas en todos los datos:

```r
sed -i 's/"/ /g' tabla.txt
```
- ¿Cuántas observaciones totales?

```r
wc -l tabla.txt
```
 96111


## Preguntas

- ¿Cuál es el top 5 de estados?


```r
cat tabla.txt | cut -d$'\t' -f4 
| sort -t $'\t' -k 1 | uniq -c 
| sort -t $'\t' -g | tail -5
```

   4326  TX 
   
   4968  WA 
   
   5057  FL 
   
   7726   
   
  11124  CA 

## Preguntas

- ¿Cuál es el top 5 de estados por año?. Ejemplo año 99

```r
ccut -d$'\t' -f1,2,4 tabla.txt | cut -d' ' -f4,7 | cut -d'/' -f3 | sort 
| uniq -c |sort -k 2 | awk  '{if ($2=="99") print $1,$2,$3;}' 
| sort -k1 -nr | head -5
```

236 95 WA

192 95 CA

123 95 

68 95 OR

56 95 MI

## Preguntas

- ¿Cuál es la racha más larga en días de avistamientos en un estado?

  city       date reportes         freq    acum
  
1  CA  2008-11-23        4 0.0003595829    41

2      2006-08-29        1 0.0001294331    19

3  FL  2013-11-11        3 0.0005932371    17

4  WA  2010-07-17        6 0.0012077295    14

5  NY  2014-10-01        3 0.0007878151    13

6  OH  2014-07-08        2 0.0006932409    11

## Preguntas

- ¿Cuál es la racha más larga en días de avistamientos en el país?

   city       date reportes         freq       acum
   
1   CA  2008-11-23        4 0.0003595829       41

## Preguntas

- ¿Cuál es el mes con más avistamientos? 


```r
cut -d$'\t' -f1,2,4 tabla.txt | cut -d' ' -f4,7 | cut -d'/' -f1 
| sort | uniq -c |sort -g | tail -5
```
   9024 10
   
   9212 9
   
  10061 6
  
  10406 8
  
  11540 7

## Graficación  Serie de tiempo

```r
 Rscript plot_st.r CA 
#!/usr/bin/env Rscript
library(dplyr)
library(tidyr)
function(edo) {
df2 <-  df %>%
  separate(col=City, into=c("month","day","year","time")
           ,remove=F,extra="drop") %>%
  mutate(date = paste( time, sep = '/'),
         city = Shape)%>%
  select(date,city)
edo<-df2[df2$city==" edo ",]
ts <- edo %>%
  group_by(date) %>%
  summarise(reportes =n())
ts$date<-as.numeric(ts$date)
ts$date<-apply(as.matrix(ts[,1]),1, function(x) 
  { if (x>15) { x+1900 } else { x+2000 } })
plot(ts$date,ts$reportes,type = "b",col = "dark red")
}
```
## Gráfica California

![](~/CGM/UFO/RplotCA.png)




