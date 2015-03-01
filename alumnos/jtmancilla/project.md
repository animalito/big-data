---
title: "Proyecto UFO"
author: "José Antonio Mancilla"
date: "28 de febrero de 2015"
output: html_document
---

### Proyecto

- script de R para el scrapping

ufo.r

- La línea de código para la distribución en las máquinas de amazon.-

```
parallel --nonall Rscript ufo.r --slf instancias "./ufo.r"
```

**NOTA:** se anexa archivo master.sh que se hizo para configurar las maquinas aws.


#### RESPONDIENDO A LAS PREGUNTAS.

**¿Cuántas observaciones totales?**

```
 wc -l tabla.txt
```


**¿Cuál es el top 5 de estados?**

```
cat tabla.txt | cut -d$'\t' -f4 | sort -t $'\t' -k 1 | uniq -c | sort -t $'\t' -g | tail -5
```
**¿Cuál es el top 5 de estados por año?**

```
 cut -d$'\t' -f1,2,4 tabla.txt | cut -d' ' -f4,7 | cut -d'/' -f3 | sort | uniq -c |sort -k 2 |  awk  '{if ($2=="99") print $1,$2,$3;}' | sort -k1 -nr | head -5
```

**¿Cuál es la racha más larga en días de avistamientos en un estado?**

RESULTADOS.

 |city|       date| reportes|         freq|       fecha previa|    diferencia| acumulado|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:| 
 |CA| 2008-11-23|        4| 0.0003595829| 2008-11-22| 1 days|   41|
|CA| 2008-11-22|        3| 0.0002696872| 2008-11-21| 1 days|   40|
 |CA| 2008-11-21|        3| 0.0002696872| 2008-11-20| 1 days|   39|
 |CA| 2008-11-20|        7| 0.0006292700| 2008-11-19| 1 days|   38|

**script**




```r
# preparando datos (registro con fecha y ciudad de avistamiento)
df <- df %>%
  separate(col=City, into=c("month","day","year","time"),
                 regex=" ",remove=F,extra="drop") %>%
  mutate(date = paste(month, day, year, sep = '/'),
         city = Shape,
        date = as.Date(date,format='%m/%d/%y'))%>%
  select(date,city)

# Data aplicando window function lag (columna con dato previo)
data.lag <-df%>%
  group_by(city,date)%>%
  arrange(city, date)%>%
  summarise(reportes =n())%>%
  mutate(freq = reportes/sum(reportes),
        prev = lag(date),
        dif = (date -prev))

# obtenemos el acumulado. Nos interesa cuantos con 1 en dif consecutivos existen.
# significa el mayor plazo consecutivo de reportes de avistamiento.
data.lag$acum <- sequence(rle(as.character(data.lag$dif))$lengths)

#ordenamos por acumulado
data <-data.lag[with(data.lag, order(-acum)), ]

# mayor racha de avistamiento por estado
result <- data %>%
  group_by(city) %>%
  top_n(n=1)
```




**¿Cuál es el mes con más avistamientos?**

```
cut -d$'\t' -f1,2,4 prueba.txt | cut -d' ' -f4,7 | cut -d'/' -f1 | sort | uniq -c |sort -g | tail -1
```
**¿El día de la semana?**
```
cut -d $'\t' -f2,3,4 tabla.txt | sed 's/"//g' | cut -d " " -f1 | sort | uniq -c | sort | sed 's/City/ /' | sed 's/Two/ /'
```

- script de R serie de tiempo 


comando: **NOTA:** se dan dos argumentos. (el estado y el nombre para el plot)

```
cat serie.csv | Rscript plot.r CA cool
```

_script en:_  plot.r


