library(maps)
library(sp)
library(ggmap)

data(state.fips)
colors = c("gray80", "gray75", "gray70", "gray65", "gray60", "gray55","gray50","gray45","gray40","gray30","gray20")

ruta_archivo <- "C:/Users/Amanda/Documents/archivos_gran_escala/Proyecto_1/datos_UFO.txt"
df_UFO1 <- read.table(ruta_archivo, header = TRUE)

df_UFO_14 <- subset(df_UFO1, anio == 2014)
tabla1 <- df_UFO_14 %>%
  group_by(State) %>%
  summarise(no = n())

tabla1 <- data.frame(tabla1)
tabla1$abb <- tabla1$State
tabla1 <- merge(x=tabla1, y=state.fips, by = "abb", all.y=TRUE)
tabla1 <- select(tabla1, c(4,3))
tabla1$colorBuckets <- as.numeric(cut(tabla1$no, c(0,50,100,150,200,250,300,400,500,600,700,2000)))
colorsmatched <- tabla1$colorBuckets[match(state.fips$fips, tabla1$fips)]

map("state", col = colors[colorsmatched], fill =TRUE, resolution = 0, lty=0, projection = "polyconic")
map("state", col = "black", fill = FALSE, add =TRUE, lty = 1, lwd=0.2, projection = "polyconic")
title("Avistamientos 2014")