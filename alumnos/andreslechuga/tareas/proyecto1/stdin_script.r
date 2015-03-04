#!/usr/bin/env Rscript
library(dplyr)
library(tidyr)
library(ggplot2)
args <- commandArgs(trailingOnly=TRUE)
data <- read.delim("/dev/stdin", header=F, na.strings = "")
# process the data
df <- data
df <- df[complete.cases(df),]
df <- df %>%
  separate(col=V1, into=c("month","day","year","time"),
           regex=" ",remove=F,extra="drop") %>%
  mutate(date = paste(month, day, year, sep = '/'),
         city = V2,
         date = as.Date(date,format='%m/%d/%y'))%>%
  select(date,city)

#Aplicamos el lag y obtenemos las diferencias
data.lag <-df%>%
  group_by(city,date)%>%
  arrange(city, date)%>%
  summarise(reportes =n())%>%
  mutate(freq = reportes,
    prev = lag(date),
         dif = (date -prev))
head(data.lag)

# graficamos
ggplot(data.lag, aes(x = date, y = freq, color = city, group = city)) +
  geom_line() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))