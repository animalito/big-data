Primer proyecto
========================================================
author: Carlos Jared Romero Reyes
date: 4 de marzo de 2015
font-import: http://fonts.googleapis.com/css?family=Risque
font-family: 'Risque'
css: proyecto_1.css

Scrapping
==========================================================================

Primero obtenemos las dirreciones donde se encuentran las tablas:



```r
ufo_data <-html("http://www.nuforc.org/webreports/ndxevent.html")
archivos<-ufo_data%>%
  html_nodes("a") %>%
  html_attr("href")
archivos_2<-paste0("http://www.nuforc.org/webreports/",archivos[2:862])
años<-substr(archivos_2,38,41)
```

Scrapping
==========================================================================
 Luego para cada dirección obtenemos la tabla:


```r
direccion <- html(archivos_2[1])
tabla<-direccion%>%
  html_nodes(xpath='//*/table') %>%
  html_table()
a<-data.frame(año=años[1],tabla[[1]])

for(i in 2:length(archivos_2)){
  direccion <- html(archivos_2[i])
  tabla<-direccion%>%
    html_nodes(xpath='//*/table') %>%
    html_table()
  tabla<-data.frame(año=años[i],tabla[[1]])
  a<-rbind(a,tabla)}
```

Scrapping
==========================================================================
 Luego para cada dirección obtenemos la tabla:


```r
ufo_base<-data.frame(a)

write.table(ufo_base,
          "/home/jared/big-data/alumnos/jared275/UFO/ufo_base.txt",
          sep = "\t", col.names = TRUE)
```

Codigo de parallel y AWS
==========================================================================
Una vez hecho el script para scrapear las tablas, creo mis instancias y les descargo lo necesario para que puedan correr el script. Ya listas las maquinas ejecuto el siguiente comando que descarga las tablas y me las devuelve en mi maquina.

```
parallel --nonall Rscript scrap_ufo.R --slf instancias "./scrap_ufo.R"
```

¿Cuantas observaciones totales?
==========================================================================

Una vez obtenido el archivo, en linea de comandos ejecuto lo siguiente para comenzar a responder las preguntas:

```
jared@jared-Inspiron-3437:~/big-data/alumnos/jared275/UFO$ wc -l ufo_base.txt
96111 ufo_base.txt
```

¿Cuál es el top 5 de estados (más avistamientos)?
========================================================

```
jared@jared-Inspiron-3437:~/big-data/alumnos/jared275/UFO$ cut ufo_base.txt -d$'\t' -f4 |sort |uniq -c |sort -k1 -n| tail -7
   3181 "AZ"
   3808 "NY"
   4326 "TX"
   4968 "WA"
   5057 "FL"
   7726 ""
  11124 "CA"
```

¿Cuál es el top 5 de estados por año?
========================================================

En este comando tienes que específicar el año que te gustaría saber

```
jared@jared-Inspiron-3437:~/big-data/alumnos/jared275/UFO$ cut -d$'\t' -f1,2,4 ufo_base.txt | cut -d' ' -f4,7 | cut -d'/' -f3 | sort | uniq -c |sort -k 2 | awk  '{if ($2=="99") print $1,$2,$3;}' | sort -k1 -nr | head -6
400 99 CA
243 99
234 99 WA
146 99 TX
127 99 OH
109 99 IL
```

¿Cuál es el top 5 de estados por año?
========================================================

Dado que el año solo tiene 2 digitos, no se distingue por ejemplo 2000 y 1400,
por lo que lo hacemos en R, para ello solo me quedo con las columnas que me interesan.

```
cut -d$'\t' -f2,3,5 ufo_base.txt| cut -d' ' -f2,4,7 >base_ufos.csv
```


```r
base<-read.table("/home/jared/big-data/alumnos/jared275/UFO/base_ufos.csv",
                 header=F, sep="\t", stringsAsFactors=F)
names(base)<-c("año","fecha","estado")
base$fecha_ok<-as.Date(paste0(str_sub(base$fecha,1,-3),base$año),format='%m/%d/%Y')
```

¿Cuál es el top 5 de estados por año?
========================================================


```
Source: local data frame [6 x 3]
Groups: año

   año estado cuenta
1 2015     CA     81
2 2015     FL     75
3 2015     AZ     43
4 2015     TX     29
5 2015            28
6 2015     WA     27
```

¿Cuál es la racha más larga de avistamientos en un estado?
========================================================

Creamos una función para contar la racha más larga en R:


```r
dias_seg<-function(base){
  a=0
  b=0
  pos<-"fecha"
  base<-append(base,0)
  for (i in 1:(length(base)-1)){
    if(base[i]==base[i+1]-1){a<-a+1}
    else{if (a>b){
        b<-a
        a<-0
        pos<-as.character(base[i])}}}
  return(c(b, pos))}
```


¿Cuál es la racha más larga de avistamientos en un estado?
========================================================


```
   racha fecha_ultim estado
66    48  2014-10-08     NY
67    54  2014-08-18     WA
68    56  2014-09-27     TX
69    60  2014-12-21     FL
70    85  2014-11-24       
71   102  2014-11-21     CA
```


¿Cuál es la racha más larga de avistamientos en el país?
========================================================


```r
fechas_pais<-unique(base$fecha_ok)
fechas_pais<-fechas_pais[order(fechas_pais)]
dias_seg(fechas_pais)
```

```
[1] "4793"       "2015-02-19"
```

¿Cuál es el mes con más avistamientos? ¿El día de la semana?
========================================================


```r
base$mes<-format(base$fecha_ok, "%b")
base$semana<-weekdays(base$fecha_ok)
```


¿Cuál es el mes con más avistamientos?
========================================================

![plot of chunk unnamed-chunk-11](proyecto_1-figure/unnamed-chunk-11-1.png) 


¿El día de la semana?
========================================================

![plot of chunk unnamed-chunk-12](proyecto_1-figure/unnamed-chunk-12-1.png) 

Linea del tiempo
========================================================

![plot of chunk unnamed-chunk-13](proyecto_1-figure/unnamed-chunk-13-1.png) 
