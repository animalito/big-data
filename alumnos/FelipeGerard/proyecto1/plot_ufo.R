#! /usr/bin/env Rscript
# USO 1: > ./plot_ufo.R
#        > TX
#        ... *grafica de avistamientos en Texas*
# USO 1: > ./plot_ufo.R
#        > EUA
#        ... *grafica de avistamientos en EUA*
# USO 1: > ./plot_ufo.R
#        > 
#        ... *grafica de avistamientos en EUA*
# USO 2: > echo "NY" | ./plot_ufo.R

require(txtplot, warn.conflicts = F, quietly = T)
require(dplyr, warn.conflicts = F, quietly = T)

f <- file('stdin')
open(f)
cat('Proporciona un estado...\n')
state <- readLines(f, n=1)
df <- read.table('plot.data', col.names=c('Estado', 'Fecha'))
df$Fecha <- as.Date(df$Fecha)
if(state == "" || state == 'EUA' || state == 'todo'){
  cat("Graficando informacion de todo el pais...\n")
  df2 <- df %>%
    mutate(Anio=as.numeric(format(Fecha, "%Y"))) %>%
    group_by(Anio) %>%
    summarise(Avistamientos=as.numeric(n())) %>%
    mutate(FechaNum=1)
  df2$FechaNum[2:nrow(df2)] <- df2$Fecha[2:nrow(df2)] - df2$Fecha[1]
  head(df2)
  txtplot(df2$Anio, df2$Avistamientos, xlab='Anio', ylab='# en EUA')
}else{
  cat("Graficando informacion de ", state, "...\n", sep='')
  df2 <- df %>% filter(Estado==state) %>%
    mutate(Anio=as.numeric(format(Fecha, "%Y"))) %>%
    group_by(Anio) %>%
    summarise(Avistamientos=as.numeric(n())) %>%
    mutate(FechaNum=1)
  if(nrow(df2) == 0) stop("Estado invalido!")
  df2$FechaNum[2:nrow(df2)] <- df2$Fecha[2:nrow(df2)] - df2$Fecha[1]
  head(df2)
  txtplot(df2$Anio, df2$Avistamientos, xlab='Anio', ylab=paste('# en', state))
}