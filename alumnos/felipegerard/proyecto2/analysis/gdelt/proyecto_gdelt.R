
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(ggmap)

#####################################################
# Responde preguntas similares a las anteriores
#####################################################

# Primer/último evento de cada país
#####################################################

# Evento con máxima/mínima escala de Goldstein por país?
#####################################################

# Promedio mensual de eventos
#####################################################



#####################################################
# Clusters de países: Temporal
#####################################################

gdelt_1 <- read.csv('output/monthyear_actors_count_full.psv', header = T, sep = '|')
dim(gdelt_1)
head(gdelt_1)

# Filtramos y construimos la fecha
x1 <- gdelt_1 %>%
  mutate(aux = as.character(monthyear),
         year = substr(aux,1,4),
         month = substr(aux,5,6),
         date = as.Date(paste(year, month, '01'), format = '%Y %m %d')) %>%
  group_by(actor1name) %>%
  filter(sum(numevents) > 200000) %>% # Mexico tenía como 700,000
  ungroup

# Ejemplo: Gráficas de ts
x2 <- filter(x1, actor1name %in% c('MEXICO','BRAZIL','VENEZUELA','HAITI'))
ggplot(x2, aes(date, numevents)) +
  geom_line() +
  facet_wrap(~ actor1name)

# Correlaciones? --> Mejor K Means
gdelt_ts <- x1 %>%
  dplyr::select(actor1name, actor1name, date, numevents) %>%
  mutate(actor1name = gsub(' ', '_', actor1name)) %>%
  spread(actor1name, numevents)
gdelt_ts[is.na(gdelt_ts)] <- 0 # No hubo noticias
dim(gdelt_ts)

x <- cor(gdelt_ts[-1])[,'MEXICO']
cor_mex <- data.frame(country = names(x), cor_mex = as.numeric(x)) %>%
  arrange(desc(cor_mex))

#############
# KMEANS
#############
# K Means temporal: Por número de eventos (numevents, nclu = 20)
  # [1] "LIBYA"       "LIBYAN"      "LONDON"      "LOS_ANGELES" "MALAYSIA"    "MALAYSIAN"  
  # [7] "MAYOR"       "MEDIA"       "MEXICO"      "MIAMI"       "MILITANT"    "MILITARY"   
  # [13] "MINIST"      "MINISTRY"

# K Means temporal: Por número de menciones (nummentions, nclu=20)
  # RUN 1
    # [1] "JAPANESE"    "JERUSALEM"   "JEWISH"      "JORDAN"      "JOURNALIST"  "JUDGE"      
    # [7] "KAZAKHSTAN"  "KENYA"       "KING"        "KUWAIT"      "LAWMAKER"    "LAWYER"     
    # [13] "LEBANESE"    "LEBANON"     "LIBYA"       "LIBYAN"      "LONDON"      "LOS_ANGELES"
    # [19] "MALAYSIA"    "MALAYSIAN"   "MAYOR"       "MEDIA"       "MEXICO"      "MIAMI"      
    # [25] "MILITANT"    "MILITARY"    "MINIST"      "MINISTRY"
  # RUN 2
    # "MEDIA"    "MEXICO"   "MIAMI"    "MILITANT" "MILITARY" "MINIST"   "MINISTRY"
  # RUN 3
    # "MEDIA"    "MEXICO"   "MIAMI"    "MILITANT" "MILITARY" "MINIST"   "MINISTRY"

# K Means temporal: Por impacto de escala de Goldstein (goldsteinscale, nclu = 20)
  # RUN 1
    # [1] "LIBYA"       "LIBYAN"      "LONDON"      "LOS_ANGELES" "MALAYSIA"    "MALAYSIAN"  
    # [7] "MAYOR"       "MEDIA"       "MEXICO"      "MIAMI"       "MILITANT"    "MILITARY"   
    # [13] "MINISTRY"
  # RUN 2
    # [1] "LIBYA"       "LIBYAN"      "LONDON"      "LOS_ANGELES" "MALAYSIA"    "MALAYSIAN"  
    # [7] "MAYOR"       "MEDIA"       "MEXICO"      "MIAMI"       "MILITANT"    "MILITARY"   
    # [13] "MINISTRY"
  # RUN 3
    # [1] "LIBYA"       "LIBYAN"      "LONDON"      "LOS_ANGELES" "MALAYSIA"    "MALAYSIAN"  
    # [7] "MAYOR"       "MEDIA"       "MEXICO"      "MIAMI"       "MILITANT"    "MILITARY"   
    # [13] "MINIST"      "MINISTRY"    "MOSCOW"      "MUSLIM"      "MYANMAR"     "NATO"       
    # [19] "NEPAL"       "NEW_DELHI"   "NEW_YORK"    "NEW_ZEALAND" "NEWSPAPER"   "NIGERIA"    
    # [25] "NIGERIAN"

# K Means esférico temporal: Por número de menciones (nummentions, nclu = 15)
  # RUN 1
    # [1] "LIBYA"       "LIBYAN"      "LONDON"      "LOS_ANGELES" "MALAYSIA"    "MALAYSIAN"  
    # [7] "MAYOR"       "MEDIA"       "MEXICO"      "MIAMI"       "MILITANT"    "MILITARY"   
    # [13] "MINIST"      "MINISTRY"    "MOSCOW"      "MUSLIM"      "MYANMAR"     "NATO"       
    # [19] "NEPAL"       "NEW_DELHI"   "NEW_YORK"    "NEW_ZEALAND" "NEWSPAPER"   "NIGERIA"    
    # [25] "NIGERIAN"    "NORTH_KOREA" "NORWAY"      "OBAMA"
  # RUN 2
    # [1] "LIBYA"       "LIBYAN"      "LONDON"      "LOS_ANGELES" "MALAYSIA"    "MALAYSIAN"  
    # [7] "MAYOR"       "MEDIA"       "MEXICO"      "MIAMI"       "MILITANT"    "MILITARY"   
    # [13] "MINIST"      "MINISTRY"

gdelt_clu <- x1 %>%
  dplyr::select(actor1name, actor1name, date, goldsteinscale) %>%
  mutate(actor1name = gsub(' ', '_', actor1name)) %>%
  spread(date, goldsteinscale)
gdelt_clu[is.na(gdelt_clu)] <- 0 # No hubo noticias
gdelt_clu[-1] <- apply(gdelt_clu[-1], 1, function(x) x/sqrt(sum(x*x))) # Normalizamos

dim(gdelt_clu)

kms <- list()
for(i in 2:30){
  kms[[i]] <- kmeans(gdelt_clu[-1], centers = i, trace = T)
}
x <- unlist(lapply(kms, function(x) x$tot.withinss/x$totss))
qplot(2:30, x, geom='line')
# Cuantos clusters usar?
nclu <- 20
km1 <- kms[[nclu]]
gdelt_clu$cluster <- km1$cluster
head(gdelt_clu)

clu_mex <- gdelt_clu %>%
  group_by(cluster) %>%
  filter('MEXICO' %in% actor1name)
clu_mex$actor1name
clmx <- clu_mex$cluster[clu_mex$actor1name == 'MEXICO']
km1_df1 <- data.frame(cluster = 1:nclu,
                      size = km1$size,
                      perc_within = (km1$withinss/km1$tot.withinss), 
                      times_mean_perc_within = (km1$withinss/km1$tot.withinss) / 0.1, # Veces la varianza within promedio
                      betweenss = km1$betweenss,
                      totss = km1$totss) %>%
  mutate(color = ifelse(cluster == clmx, 'mex', 'other'))
km1_df2 <- gather(km1_df1, key, value, size:totss)
ggplot(filter(km1_df2, key %in% c('size', 'perc_within')), aes(cluster, value, fill=color)) +
  geom_bar(stat='identity') +
  facet_wrap(~ key, scales = 'free_y')

####
# K Means esférico temporal: Por número de menciones
library(skmeans)
gdelt_clu <- x1 %>%
  dplyr::select(actor1name, actor1name, date, nummentions) %>%
  mutate(actor1name = gsub(' ', '_', actor1name)) %>%
  spread(date, nummentions)
gdelt_clu[is.na(gdelt_clu)] <- 0 # No hubo noticias
gdelt_clu[-1] <- apply(gdelt_clu[-1], 1, function(x) x/sqrt(sum(x*x))) # Normalizamos

dim(gdelt_clu)

km1 <- skmeans(as.matrix(gdelt_clu[-1]), k = 15)

# kms <- list()
# for(i in 2:30){
#   kms[[i]] <- kmeans(gdelt_clu[-1], centers = i, trace = T)
# }
# x <- unlist(lapply(kms, function(x) x$tot.withinss/x$totss))
# qplot(2:30, x, geom='line')
# ==> Elegimos usar 15 clusters
# nclu <- 15
# km1 <- kms[[nclu]]
gdelt_clu$cluster <- km1$cluster
head(gdelt_clu)

clu_mex <- gdelt_clu %>%
  group_by(cluster) %>%
  filter('MEXICO' %in% actor1name)
clu_mex$actor1name
clmx <- clu_mex$cluster[clu_mex$actor1name == 'MEXICO']
# km1_df1 <- data.frame(cluster = 1:nclu,
#                       size = km1$size,
#                       perc_within = (km1$withinss/km1$tot.withinss), 
#                       times_mean_perc_within = (km1$withinss/km1$tot.withinss) / 0.1, # Veces la varianza within promedio
#                       betweenss = km1$betweenss,
#                       totss = km1$totss) %>%
#   mutate(color = ifelse(cluster == clmx, 'mex', 'other'))
# km1_df2 <- gather(km1_df1, key, value, size:totss)
# ggplot(filter(km1_df2, key %in% c('size', 'perc_within')), aes(cluster, value, fill=color)) +
#   geom_bar(stat='identity') +
#   facet_wrap(~ key, scales = 'free_y')
# ggplot(km1_df1, aes(size, perc_within)) +
#   geom_point()



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

























