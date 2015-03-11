#! /usr/bin/Rscript
# Luis Manuel Román García
# Métodos de gran escala
# Proyecto 1
########################
# Este código recibe los datos provenientes de la página web
# y lleva a cabo el proceso de limpieza y estructuración.
########################
# Directorio de trabajo
setwd("~/ITAM/primavera15/projects/ufo")
########################
# Librerías utilizadas
library(plyr)
library(dplyr)
library(stringr)
library(tm)
library(tidyr)
########################
# Lectura de datos
# Registros UFO
# En caso de que se quiera leer desde la terminal simplemente reemplazar
  data <-  read.table(file('stdin'),header = TRUE,
                                             stringsAsFactors = FALSE,
                                             na.strings = c("NA",""," "))
#data                 <- read.table("./data/input/tabla.txt",
#                                             header = TRUE,
#                                             stringsAsFactors = FALSE,
#                                             na.strings = c("NA",""," "))
names(data)     <- tolower(names(data))
names(data)[1] <- "date_time"
########################
# Procesamiento de datos
# Separar hora y fecha
data                <- separate(data,date_time,
                                             c("date","time"),
                                             sep = "[[:blank:]]",
                                             extra = "drop")
# Convertir fechas a tipo fecha
data$date       <- as.Date(data$date,
                                        "%m/%d/%y")
data$posted    <- as.Date(data$posted,
                                      "%m/%d/%y")
# Poner descripciones en minúsculas
data$shape      <- tolower(data$shape)
# Limpiar datos de duración
data$duration  <- data$duration %>%
                    str_trim() %>%
                    str_replace("((min).*)", "min") %>%
                    str_replace("((sec).*)", "sec") %>%
                    str_replace("((hou).*)", "hr") %>%
                    str_replace_all("[[:punct:]].*", "") %>%
                    str_match("[[:digit:]]+.*[[:alpha:]]+")%>%
                    str_trim
# Pasar a una misma escala (todo a segundos)
data                <- separate(data,duration,
                                              c("duration","scale"),
                                              sep = "[[:blank:]]",
                                              extra = "drop")
data$duration <- extract_numeric(data$duration)
for(i in 1:nrow(data)){
    if(!is.na(data$scale[i])){
        if(data$scale[i] == "hr"){
            data$duration[i] <- data$duration[i] * 3600
        }else if(data$scale[i] == "min"){
            data$duration[i] <- data$duration[i] * 60
        }
    }
}
data$scale <- NULL
# Eliminar columnas no necesarias para los fines de este proyecto.
data <- data[,c(1,2,4,5,6,8)]
# Seleccionamos únicamente aquellos datos que aparecen en EUA
# Abreviaciones USA
con <- file("./data/input/abrevs.txt")
abrev <- readLines(con)
close(con)
data <- subset(data, state %in% abrev)
# Eliminamos datos faltantes.
data <- na.omit(data)
# Escribimos datos límpios.
print("los datos están limpios")
write.csv(data,"./data_clean.csv",row.names = FALSE)
closeAllConnections()
