#!/usr/bin/env Rscript

# Cargando librerias
library(dplyr)
library(ggplot2)

# Leyendo informaciÃ³n del stdin
f <- file("stdin")
open(f)
datos <- read.table(f) 
ruta_archivo <- datos[1,1]
tipo_graf <- datos[1,2]
df_UFO1 <- read.table(ruta_archivo, header = TRUE)

#Datos para grÃ¡fica total
if (tipo_graf == "TOTAL") {
  # Obteniendo nÃºmero de avistamientos por mes
  tabla <- df_UFO1 %>%
    group_by(mes, anio) %>%
    summarise(no = n())
}
tipo_graf <- "TX"
#Datos para grÃ¡fica por estado
if (tipo_graf != "TOTAL") {
  # Obteniendo nÃºmero de avistamientos por mes y estado
  tabla <- df_UFO1 %>%
    filter(State == tipo_graf) %>%
    group_by(mes, anio) %>%
    summarise(no = n())
}

tabla <- tabla[with(tabla, order(anio)), ]
tabla$periodo <- paste0(tabla$mes, "_", tabla$anio)
perio <- tabla$periodo

# Obtenemos grÃ¡fica
#tabla <- data.frame(tabla)

ggplot(data = tabla, aes(x = periodo, y = no)) + 
  geom_line(aes(group = 1), size = 0.3) +
  geom_point(size = 1, colour = "red") +
  guides(fill = FALSE) +
  xlab("") + ylab("") +
  ggtitle(paste0("Avistamientos ", tipo_graf)) +
  theme(axis.text.x = element_text(angle = 90, size = 1)) +
  scale_x_discrete(limits=perio)


#Guardamos la grÃ¡fica
setwd("C:/Users/Amanda/Documents/archivos_gran_escala/Proyecto_1/imagen")
nombre_graf <- paste0("graf_", tipo_graf, ".png")
dev.copy(png, nombre_graf)
dev.off()

close(f)