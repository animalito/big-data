#! /usr/bin/env Rscript
require(dplyr, quietly = TRUE, warn.conflicts = FALSE)
f <- file('stdin')
open(f)

df <- read.table(f, header = F, sep = "\t", skipNul = T, stringsAsFactors = F)
# df <- read.table('~/big-data/alumnos/FelipeGerard/proyecto1/prueba',header = F,
#                  sep = "\t",skipNul = T, stringsAsFactors = F)
colnames(df) <- c('state', 'chardate')
df$date <- as.Date(df$chardate)
df <- filter(df, !is.na(date)) %>%
  unique

df$dif <- 1
df$racha <- 1
df$inicio <- as.Date('0000-01-01')
df$fin <- as.Date('0000-01-01')
df$dif[2:nrow(df)] <- df$date[2:nrow(df)] - df$date[1:(nrow(df)-1)]
inicio <- df$date[1]
fin <- inicio
# racha = 1
# for(i in 2:nrow(df)){
#   if(is.na(df$dif[i])) print(df[i,])
#   if(i %% 1000 == 0) print(i)
#   if(df$dif[i] == 1){
#     racha <- racha + 1
#     fin <- fin + 1
#   }else{
#     df$racha[i-1] <- racha
#     df$inicio[i-1] <- inicio
#     df$fin[i-1] <- fin
#     inicio <- df$date[i]
#     fin <- inicio
#     racha <- 1
#   }
# }
# 
# df <- df %>% arrange(state, desc(racha))
# idx <- tapply(1:nrow(df), df$state, function(df) head(df,1)) %>% unlist
# df2 <- df[idx,] %>% select(state, date, racha, inicio, fin)
# write.csv(df2, file=stdout())
write.csv(df[c('state', 'date', 'dif', 'racha', 'inicio', 'fin')], file=stdout())
close(f)

