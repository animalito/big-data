
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(ggmap)

#####################################################
# Análisis temporal
#####################################################

gdelt_temp <- read.csv('output/gdelt_date_count.psv', header = T, sep = '|')
dim(gdelt_temp)
head(gdelt_temp)

gdelt_year <- gdelt_temp %>%
  filter(year < 2015) %>%
  group_by(year) %>%
  summarise(count = sum(count)) %>%
  mutate(dif1 = count - lag(count))

ggplot(gdelt_year, aes(year, count)) +
  stat_smooth(method='loess') +
  geom_line() +
  geom_point() +
  geom_vline(aes(xintercept=2006), color='red', linetype='dashed', size=1)

ggplot(gdelt_year, aes(year, dif1)) +
  geom_line() +
  geom_point() +
  geom_hline(aes(yintercept=0), linetype='dashed') +
  geom_vline(aes(xintercept=2006), color='red', linetype='dashed', size=1)

#####################################################
# Análisis expacio-temporal
#####################################################

gdelt_sp <- read.csv('output/gdelt_state_year_count.psv', header = T, sep = '|')
dim(gdelt_sp)
head(gdelt_sp)

mex <- get_map(location='Mexico', zoom=4, maptype='toner')
ggmap(mex)

























