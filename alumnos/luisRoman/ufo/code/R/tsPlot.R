#!/usr/bin/Rscript
setwd("~/ITAM/primavera15/projects/ufo")
args <- commandArgs(TRUE)
########################
# Librerías utilizadas
library(RJSONIO)
library(ggplot2)
library(tidyr)
library(stringr)
library(plyr)
library(grid)
#Lectura de datos
data <- read.csv(file("stdin"), stringsAsFactors = FALSE)
data$date       <- as.Date(data$date)
data$date[str_detect(data$date,"20[2-9]{1}[0-9]{1}")] <-
str_replace(data$date[str_detect(data$date,"20[2-9]{1}[0-9]{1}")],"^20","19")
data$posted    <- as.Date(data$posted)
data$posted[str_detect(data$posted,"20[2-9]{1}[0-9]{1}")] <-
str_replace(data$posted[str_detect(data$posted,"20[2-9]{1}[0-9]{1}")],"^20","19")
# Estructura general de los gráficos
color1 <- "#2196F3"
color2 <- "#3F51B5"
color3 <- "#9E9E9E"
color4 <- "#01579B"
color5 <- "#880E4F"
theme <-       theme(panel.background = element_blank(),
                 axis.text.x = element_text(size = 10,
                                                         angle = 90,
                                                         face = "bold",
                                                         color = color2),
                 axis.text.y = element_text(size = 10,
                                                         face = "bold",
                                                         color = color2),
                 axis.title = element_blank(),
                 legend.title = element_text(size = 10,
                                                         face = "bold",
                                                         color = color2),
                legend.text = element_text(size = 7,
                                                         face = "bold",
                                                         color = color2),
                strip.text = element_text(size = 10,
                                                         face = "bold",
                                                         color = color2))
#Gráfico dependiendo del input del usuario.
history <- count(data[,c(1,3)])
state <- args[1]
if (!is.na(state)){
    history <- history[history$state == state,]
}
png("./Graph.png")
 ggplot(data = history, aes(x = date, y = freq )) +
       geom_line(alpha = .5, color = color2) +
       geom_smooth(color = color5) +
        theme
dev.off()
closeAllConnections()
