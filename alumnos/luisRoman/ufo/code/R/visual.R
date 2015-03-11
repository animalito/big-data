# Luis Manuel Román García
# Métodos de gran escala
# Proyecto 1
########################
# Este código genera las visualizaciones básicas y produce el json
# para visualizar el mapa.
########################
# Directorio de trabajo
setwd("~/ITAM/primavera15/projects/ufo")
########################
# Librerías utilizadas
library(RJSONIO)
library(ggplot2)
library(tidyr)
library(stringr)
library(plyr)
library(grid)
########################
# Lectura de datos
# Coordenadas USA
con <- file("./data/input/coords.txt")
coords <- readLines(con)
close(con)
# Abreviaciones USA
con <- file("./data/input/abrevs.txt")
abrev <- readLines(con)
close(con)
# Datos límpios
data <- read.csv("./data/output/data_clean.csv", stringsAsFactors = FALSE)
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
# Serie de tiempo general.
history <- plyr::count(data$date)
plot.global <- ggplot(data = history, aes(x = x, y = freq )) +
       geom_line(alpha = .5, color = color2) +
       geom_smooth(color = color5) +
        theme
png("./graphs/tsGlobal.png", width = 860, height = 550)
plot.global
dev.off()
# Serie de tiempo por estado.
history.State <- count(data[,c(1,3)])
plot.state <- ggplot(data = history.State, aes(x = date, y = freq, col = state)) +
       geom_line(alpha = .5) +
     # geom_smooth(aes(group= 1),
     #              fill = color3, color = color5) +
 #      scale_x_discrete(limits = seq(history$x[1],
    #                                                       history$x[nrow(history)],
       #                                                    by = 500)) +
        theme + theme(legend.key.size = unit(.2,"cm"),
                                  legend.position = "bottom" ,
                                  legend.text =element_text(size = 6, angle = 90),
                                  legend.title =element_text(size =6, angle = 90))
plot.state
png("./graphs/tsState.png", width = 860, height = 550)
plot.state
dev.off()
# Serie de tiempo top 5
years <- unique(format(history.State$date,"%Y"))
top5  <- list()
for(i in 1:length(years)){
    YearI <-  history.State[
           format(
                  history.State$date,"%Y") == years[i], ]
    YearI <- YearI[order(YearI$freq),]
    top5[[i]] <- head(YearI)
}
df.top5 <- ldply(top5,function(t)t <- t[,-3])
top.Year.plot <- ggplot(data = df.top5, aes(x = date, y = state )) +
geom_point(size = 8, alpha = .4, color = color2) + theme +
theme(axis.text.y = element_text(size = 6))
png("./graphs/topYear.png", width = 860, height = 550)
top.Year.plot
dev.off()
# histograma por día, mes y estado.
data.day      <- count(weekdays(data$date))
data.month  <- count(format(data$date, "%m"))
data.state    <- count(data$state)
# Day
hist.day       <- ggplot(data = data.day, aes(x = x, y = freq)) +
geom_histogram(stat = 'identity',fill = color2,
               alpha = .6) + theme
png("./graphs/histDay.png", width = 860, height = 550)
hist.day
dev.off()
# State
hist.state       <- ggplot(data = data.state, aes(x = x, y = freq)) +
geom_histogram(stat = 'identity',fill = color2,
               alpha = .6) + theme
png("./graphs/histState.png", width = 860, height = 550)
hist.state
dev.off()
# Month
hist.month       <- ggplot(data = data.month, aes(x = x, y = freq)) +
geom_histogram(stat = 'identity',fill = color2,
               alpha = .6) + theme
png("./graphs/histmonth.png", width = 860, height = 550)
hist.month
dev.off()
#
########################
#Preparando visualización en mapa.
#Observaciones por estado
obs.State <- count(data$state)
list.coords <- list()
j <- 1
i <- 1
for(j in seq(1,length(coords),3)){
    #Aprovechando el orden alfabético
    item <- list()
    item[[1]] <- abrev[i]
    item[[2]] <- extract_numeric(coords[j + 1])
    item[[3]] <- extract_numeric(coords[j + 2])
    item[[4]] <- obs.State[i,2]
    list.coords[[i]] <- item
    i <- i + 1
}

obsState.list <- c()
j <- 1
for (i in 1:length(list.coords)){
    obsState.list[j] <- paste('citymap["',list.coords[[i]][[1]],'"]={',sep = '')
    obsState.list[j + 1] <- paste('center:new google.maps.LatLng(',
                                          list.coords[[i]][[2]],',',
                                          list.coords[[i]][[3]],'),', sep = '')
    obsState.list[j + 2] <- paste('population:',list.coords[[i]][[4]],sep = '')
    obsState.list[j + 3] <- '};'
    j <- j + 4
}
obsState.list
fileConn<-file("./data/output/obsState.txt")
writeLines(obsState, fileConn)
close(fileConn)
#Preparar datos para visualización serie de tiempo.
data.json <- list()
for(i in 1:nrow(data)){
    item <- list( "date"       =as.character(data[i,1]),
                       "time"       =data[i,2],
                       "duration" =data[i,5],
                       "state"      =data[i,3])
    data.json[[i]] <- item
}
timeList <- toJSON(data.json)
write(timeList, file="./data/output/tsFull.json")
