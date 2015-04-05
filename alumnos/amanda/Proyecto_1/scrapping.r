#!/usr/bin/env Rscript

# Cargamos librerias
library(rvest)
library(dplyr)

# Leyendo informaciÃ³n del stdin
f <- file("stdin")
open(f)
datos <- read.table(f)
datos <- data.frame(datos)

# Descargamos cada una de las tablas por día
for (i in 1:nrow(datos)){
  table <- daily_urls[i] %>%
    html  %>%
    html_table(fill = TRUE)
  
# Obtenemos los datos de año, mes y día que corresponden a cada tabla
  table1 <- data.frame(table)
  anio <- substr(daily_urls[i], 38, 41)
  mes <- substr(daily_urls[i], 42, 43)
  tamanio <- nchar(table1$Date...Time)
  dia <- c()
  for (j in 1:nrow(table1)){
    if (as.numeric(mes) < 10){
      if (tamanio[j] == 13){
        v_dia <- substr(table1$Date...Time[j],3,4)
      }
      if (tamanio[j] == 12){
        v_dia <- paste0("0", substr(table1$Date...Time[j],3,3))
      }
      if (tamanio[j] == 7){
        v_dia <- substr(table1$Date...Time[j],3,4)
      }
      if (tamanio[j] == 6){
        v_dia <- paste0("0", substr(table1$Date...Time[j],3,3))
      }
    }
    if (as.numeric(mes) > 9){
      if (tamanio[j] == 14){
        v_dia <- substr(table1$Date...Time[j],4,5)
      }
      if (tamanio[j] == 13){
        v_dia <- paste0("0", substr(table1$Date...Time[j],4,4))
      }
      if (tamanio[j] == 8){
        v_dia <- substr(table1$Date...Time[j],4,5)
      }
      if (tamanio[j] == 7){
        v_dia <- paste0("0", substr(table1$Date...Time[j],4,4))
      }
    }
    dia <- c(dia, v_dia)
  }
  
  # Incliomos en las tablas los datos de año, mes, dia, dia_mes fecha, fecha numérica y día de la semana
  table1$anio <- anio
  table1$mes <- mes
  table1$mes <- as.numeric(df_UFO1$mes)
  table11$mes <- as.character(df_UFO1$mes)
  table1$dia <- dia
  table1$dia <- as.numeric(df_UFO1$dia)
  table1$dia <- as.character(df_UFO1$dia)
  table1$anio_mes <- paste0(anio, mes)
  table$fecha <- paste0(df_UFO$anio, "-", df_UFO$mes, "-", df_UFO$dia)
  table$fecha <- as.Date(df_UFO$fecha)
  table$fecha1 <- as.numeric(df_UFO$fecha)
  table1$dia_sem <- weekdays(df_UFO1$fecha)
  table1$dia_sem[df_UFO1$dia_sem == 'sábado'] <- 'sabado'
  table1$dia_sem[df_UFO1$dia_sem == 'miércoles'] <- 'miercoles' 
  
# vamos generando el data.frame con todas las observaciones
  if (i == 1){
    df_UFO <- table1
  }
  if (i > 1){
    df_UFO <- rbind(df_UFO, table1)
  }
  # Guardamos las tablas por día
  nombre <- paste0(mes, "_", anio, ".txt")
  write.table(table1, paste0("C:/Users/Amanda/Documents/archivos_gran_escala/Proyecto1/", nombre), sep = "\t")
}  

# Reacomodamos las columnas
df_UFO <- select(df_UFO, c(8, 9, 10, 11, 12, 13, 14, 15, 1:7))
# Guardamos el data.frame que incluye todos los registros
write.table(df_UFO, "C:/Users/Amanda/Documents/archivos_gran_escala/Proyecto1/datos_UFO.txt", sep = "\t")

close(f)