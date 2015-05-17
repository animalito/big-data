
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

# Estadísticas básicas mensuales por país
#####################################################

# Promedio mensual de eventos CHECK
#####################################################



#####################################################
# Clusters de países: Temporal
#####################################################

gdelt_1 <- read.csv('output/monthyear_actor1countrycode_stats_full_countryname.psv', header = T, sep = '|')
countrynames <- read.csv('etc/countrycodes.psv', header = F, sep = '|')
names(countrynames) <- c('actor1countrycode','actor1countryname')
dim(gdelt_1)
head(gdelt_1)
sort(unique(gdelt_1$actor1countrycode))

# Filtramos y construimos la fecha
x1 <- gdelt_1 %>%
  mutate(aux = as.character(monthyear),
         year = substr(aux,1,4),
         month = substr(aux,5,6),
         date = as.Date(paste(year, month, '01'), format = '%Y %m %d')) %>%
  group_by(actor1countrycode) %>%
  filter(sum(numevents) > 200000) %>% # Mexico tenía como 700,000
  ungroup

# Correlaciones --> Países parecidos a México
gdelt_ts <- x1 %>%
  dplyr::select(actor1countrycode, actor1countrycode, date, numevents) %>%
  mutate(actor1countrycode = gsub(' ', '_', actor1countrycode)) %>%
  spread(actor1countrycode, numevents)
gdelt_ts[is.na(gdelt_ts)] <- 0 # No hubo noticias
dim(gdelt_ts)

x <- cor(gdelt_ts[-1])[,'MEX']
#x <- factor(x, levels = levels(x)[order(x)])
cor_mex <- data.frame(country = names(x), cor_mex = as.numeric(x)) %>%
  arrange(desc(cor_mex)) %>%
  left_join(countrynames, by = c('country'='actor1countrycode'))
cor_mex$country <- factor(factor(cor_mex$country),
                          levels = cor_mex$country[order(cor_mex$cor_mex)],
                          ordered = T)
ggplot(cor_mex, aes(country, cor_mex)) +
  geom_bar(stat='identity') +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Ejemplo: Gráficas de ts
x2 <- filter(x1, actor1countrycode %in% c('MEX','USA','IRQ','HRV')) %>%
  group_by(actor1countrycode) %>%
  mutate(numevents_norm = numevents / max(numevents))
ggplot(x2, aes(date, numevents_norm)) +
  geom_line() +
  facet_wrap(~ actor1countryname)

#############
# JERÁRQUICO
#############

dist_ts <- as.dist(1 - cor(gdelt_ts[-1]))
hclus_1 <- hclust(dist_ts, method = 'complete')
plot(hclus_1)
hclus_2 <- rect.hclust(hclus_1, k=5)
plot(hclus_1)
hclus_2 <- rect.hclust(hclus_1, k=10)
plot(hclus_1)
hclus_2 <- rect.hclust(hclus_1, k=30)

# ==> No se ven clusters bien definidos. Siempre hay unos con una mix muy heterogéneo

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
  dplyr::select(actor1countrycode, actor1countryname, date, goldsteinscale) %>%
  spread(date, goldsteinscale)
gdelt_clu[is.na(gdelt_clu)] <- 0 # No hubo noticias
gdelt_clu[-(1:2)] <- apply(gdelt_clu[-(1:2)], 1, function(x) x/sqrt(sum(x*x))) # Normalizamos

dim(gdelt_clu)

kms <- list()
for(i in 2:100){
  kms[[i]] <- kmeans(gdelt_clu[-(1:2)], centers = i, trace = T)
}
x <- unlist(lapply(kms, function(x) x$tot.withinss/x$totss))
qplot(2:(length(x)+1), x, geom='line')
# Cuantos clusters usar?
nclu <- 20
km1 <- kms[[nclu]]
gdelt_clu$cluster <- km1$cluster
head(gdelt_clu)

clu_mex <- gdelt_clu %>%
  group_by(cluster) %>%
  filter('MEX' %in% actor1countrycode)
clu_mex$actor1countryname
clmx <- clu_mex$cluster[clu_mex$actor1countrycode == 'MEX']
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
  dplyr::select(actor1countrycode, actor1countrycode, date, nummentions) %>%
  mutate(actor1countrycode = gsub(' ', '_', actor1countrycode)) %>%
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
  filter('MEX' %in% actor1countrycode)
clu_mex$actor1countrycode
clmx <- clu_mex$cluster[clu_mex$actor1countrycode == 'MEXICO']
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


























