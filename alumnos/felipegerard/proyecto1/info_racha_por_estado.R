#! /usr/bin/env Rscript
require(dplyr, quietly = TRUE, warn.conflicts = FALSE)
f <- file('stdin')
open(f)

df <- read.table(f, header = F, sep = "\t", skipNul = T, stringsAsFactors = F)
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

write.csv(df[c('state', 'date', 'dif', 'racha', 'inicio', 'fin')], file=stdout())
close(f)

