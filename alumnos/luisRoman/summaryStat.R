#! /usr/bin/Rscript

library(stringr)
library(dplyr)
library(tidyr)
library(data.table)

data <- file("stdin")
data<- read.table("/home/lgarcia/ITAM/primavera15/big-data/lecture_2/data/UFO-Dic-2014.tsv",
                  sep = "\t",
                  header = TRUE,
                  stringsAsFactors = FALSE)
duration <- data$Duration %>%
                    str_trim() %>%
                    str_replace("((min).*)", "min") %>%
                    str_replace("((sec).*)", "sec") %>%
                    str_replace("((hou).*)", "hr") %>%
                    str_replace_all("[[:punct:]].*", "") %>%
                    str_match("[[:digit:]]+.*[[:alpha:]]+")%>%
                    str_trim %>%
                    na.omit()
duration
duration <- data.frame(duration)
names(duration) <- "tiempo"
duration <- separate(duration,
                     tiempo,
                     c("tiempo","unidad_temporal"),
                     sep = "[[:blank:]]+")

duration$tiempo <- extract_numeric(duration$tiempo)
duration <- data.table(duration)%>%
                    setkey(unidad_temporal)
duration[,{summary(tiempo)},
by = unidad_temporal]



