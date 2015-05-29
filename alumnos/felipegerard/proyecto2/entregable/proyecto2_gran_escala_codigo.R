## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(ggmap)
library(RColorBrewer)
library(knitr)
setwd("/Users/Felipe/big-data/alumnos/felipegerard/proyecto2")
# Leemos la base que limpiamos en postgres
ufo <- read.table('output/ufo_usa.psv', header = T, sep = '|', quote = "", stringsAsFactors = F, fill = T,
                  colClasses = rep('character',18))

long_vars <- c(15,17,18) # Columnas de texto largas
################################################################
# Limpieza aparte de lo de postgres
################################################################

#data.frame(sapply(ufo,class))
for(x in c('year','month','day','weekday','number','seconds')){
  ufo[[x]] <- as.numeric(ufo[[x]])
}
ufo <- filter(ufo, nchar(origin) < 20)  %>% # Algunos renglones venían mal
  mutate(id = row_number())
#dim(ufo)

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
### Para lo espacial
state_abbr <-
  matrix(c("alabama", "AL", "alaska", "AK", "arizona", "AZ", "arkansas", "AR", "california", "CA",
           "colorado", "CO", "connecticut", "CT", "district of columbia", "DC", "delaware", "DE", "florida", "FL", "georgia", "GA",
           "hawaii", "HI", "idaho", "ID", "illinois", "IL", "indiana", "IN", "iowa", "IA", "kansas", "KS",
           "kentucky", "KY", "louisiana", "LA", "maine", "ME", "maryland", "MD", "massachusetts", "MA",
           "michigan", "MI", "minnesota", "MN", "mississippi", "MS", "missouri", "MO", "montana", "MT",
           "nebraska", "NE", "nevada", "NV", "new hampshire", "NH", "new jersey", "NJ", "new mexico", "NM",
           "new york", "NY", "north carolina", "NC", "north dakota", "ND", "ohio", "OH", "oklahoma", "OK",
           "oregon", "OR", "pennsylvania", "PA", "rhode island", "RI", "south carolina", "SC",
           "south dakota", "SD", "tennessee", "TN", "texas", "TX", "utah", "UT", "vermont", "VT",
           "virginia", "VA", "washington", "WA", "west virginia", "WV", "wisconsin", "WI", "wyoming", "WY"),
         ncol=2, byrow=T) %>%
  data.frame(stringsAsFactors = F)
names(state_abbr) <- c('region', 'state')


## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
dim(ufo)

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
cols <- data.frame(columna=names(ufo), tipo=sapply(ufo, class), row.names = NULL)
cols$descripcion <- c('Archivo de origen del registro',
                      'ID único del registro',
                      'Fecha y hora del avistamiento',
                      'Año','Mes','Día','Día de la semana (0=domingo, 6=sábado)',
                      'Ciudad en la que fue avistado el UFO',
                      'Estado en el que fue avistado el UFO',
                      'Forma del objeto',
                      'Duración del avistamiento',
                      'Número leído del campo de duración',
                      'Unidades leídas del campo de duración',
                      'Segundos que duró el avistamiento (número*segundos/unidades)',
                      'Resumen de la descripción',
                      'Fecha y hora de subida a la base',
                      'URL de la descripción larga',
                      'Descripción larga')
cols

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
head(ufo %>% select(-summary, -long_description, -description_url))
tail(ufo %>% select(-summary, -long_description, -description_url))

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
ufo$summary[1]
ufo$long_description[1]

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
col_classes <- sapply(ufo, class) %>% as.character
cols_char <- which(col_classes == 'character')
cols_num <- which(col_classes != 'character')
summary(ufo[cols_num])
apply(ufo[cols_char], 2, function(x) c('length'=length(x),
                                       '# empty'=sum(x == ''),
                                       '% empty'=mean(x == ''))) %>%
  round(2) %>%
  format(scientific = F)

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
ufo %>%
  filter(!is.na(year)) %>%
  group_by(state) %>%
  arrange(state, year) %>%
  filter(row_number() == 1) %>%
  dplyr::select(state, date_time, city, shape, duration, seconds, posted)

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
ufo %>%
  filter(shape != '') %>%
  group_by(shape) %>%
  arrange(shape, year) %>%
  filter(row_number() == 1) %>%
  dplyr::select(state, date_time, city, shape, duration, seconds, posted)

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
yearly_sightings <- ufo %>%
  filter(date_time != '', year < 2015) %>% # Este año no está completo
  group_by(year) %>%
  summarise(count = n()) %>%
  arrange(year)
ggplot(yearly_sightings, aes(year,count)) +
  geom_line() +
  geom_point()

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
ufo %>%
  filter(date_time != '') %>%
  group_by(year, month) %>%
  summarise(count = n()) %>%
  ungroup %>%
  summarise(monthly_mean = mean(count))

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
ufo %>%
  filter(date_time != '') %>%
  group_by(year) %>%
  summarise(count = n()) %>%
  ungroup %>%
  summarise(yearly_mean = mean(count))

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
monthly_sightings1 <- ufo %>%
  filter(date_time != '', year < 2015) %>%
  group_by(year, month) %>%
  summarise(count = n()) %>%
  group_by(month) %>%
  summarise(avg_sightings = mean(count)) %>%
  arrange(month)
monthly_sightings1$month_name <- factor(month.abb, levels = month.abb)
ggplot(monthly_sightings1, aes(month_name, avg_sightings)) +
  geom_bar(stat='identity') +
  labs(x='', y='', title='Promedio de avistamientos por mes')

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
monthly_sightings2 <- ufo %>%
  filter(state != '', date_time != '', year < 2015) %>%
  group_by(state, year, month) %>%
  summarise(count = n()) %>%
  group_by(state) %>%
  summarise(avg_sightings = mean(count)) %>%
  arrange(avg_sightings) %>%
  mutate(state_ordered = factor(state, levels = state))
ggplot(monthly_sightings2, aes(state_ordered, avg_sightings)) +
  geom_bar(stat='identity') +
  labs(x='', y='', title='Promedio de avistamientos por mes') +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

### Mapa
state_info <- state.x77 %>%
  as.data.frame %>%
  mutate(region = tolower(rownames(state.x77)))
names(state_info) <- tolower(names(state_info))
names(state_info)[c(4,6)] <- c('life_exp', 'hs_grad')
us_states <- map_data('state')
states_df <- us_states %>%
  left_join(state_abbr) %>%
  left_join(monthly_sightings) %>%
  left_join(state_info) %>%
  mutate(avg_sightings_per_capita = avg_sightings / population)
#head(states_df)
centers <- data.frame(state.center, state=state.abb)
names(centers) <- c('long','lat','state')
ggplot(states_df) +
  geom_polygon(aes(long,lat,group=group, fill=avg_sightings)) +
  geom_text(data=centers, aes(long, lat, label=state), color='grey') +
  labs(title = 'Avistamientos por estado') +
  coord_quickmap()
ggplot(states_df) +
  geom_polygon(aes(long,lat,group=group, fill=avg_sightings_per_capita)) +
  geom_text(data=centers, aes(long, lat, label=state), color='grey') +
  labs(title = 'Avistamientos por estado por persona') +
  coord_quickmap()

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
monthly_state_var <- ufo %>%
  filter(state != '') %>%
  group_by(state, year, month) %>%
  summarise(count = n()) %>%
  group_by(state) %>%
  summarise(monthly_sd = sd(count),
            monthly_mean = mean(count),
            monthly_sd_mean_ratio = monthly_sd/monthly_mean,
            count = sum(count)) %>%
  arrange(desc(monthly_sd)) %>%
  mutate(state_ordered = factor(state, levels = state))
#monthly_state_var
ggplot(monthly_state_var, aes(state_ordered, monthly_sd)) +
  geom_bar(stat='identity') +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggplot(monthly_state_var, aes(state_ordered, monthly_sd_mean_ratio)) +
  geom_bar(stat='identity') +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
# ggplot(monthly_state_var, aes(count, monthly_sd_mean_ratio)) +
#   geom_point()

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
aux <- yearly_sightings %>%
  mutate(group = ifelse(year < 1940, '< 1940', '1940+'))
ggplot(aux, aes(year, count, color=group)) +
  geom_line() +
  geom_point() +
  scale_y_log10() +
  geom_smooth(method = 'lm')

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
state_sightings_block <- ufo %>%
  filter(state != '') %>%
  mutate(block = cut(year, c(1800,seq(1950,2020,10)), dig.lab = 4)) %>%
  group_by(state, block) %>%
  summarise(sightings = n())
states_df_block <- fortify(us_states) %>%
  left_join(state_abbr) %>%
  left_join(state_sightings_block) %>%
  left_join(state_info) %>%
  mutate(sightings_per_capita = sightings / population) %>%
  filter(!is.na(block))
ggplot(states_df_block) +
  geom_polygon(aes(long,lat,group=group, fill=sightings)) +
  geom_text(data=centers, aes(long, lat, label=state), color='grey', size = 3) +
  facet_wrap(~ block) +
  labs(title = 'Avistamientos a lo largo del tiempo') +
  theme(legend.position='none') +
  coord_quickmap()
ggplot(states_df_block) +
  geom_polygon(aes(long,lat,group=group, fill=sightings_per_capita)) +
  geom_text(data=centers, aes(long, lat, label=state), color='grey', size = 3) +
  facet_wrap(~ block) +
  labs(title = 'Avistamientos por persona (pob. 1975) a lo largo del tiempo') +
  theme(legend.position='none') +
  coord_quickmap()

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
state_narratives <- ufo %>%
  filter(state != '') %>%
  mutate(long_desc_len = nchar(long_description)) %>%
  group_by(state) %>%
  summarise(mean_long_desc_len = mean(long_desc_len))
states_df_narr <- left_join(states_df, state_narratives)
head(states_df_narr)
ggplot(states_df_narr) +
  geom_polygon(aes(long,lat,group=group, fill=mean_long_desc_len)) +
  geom_text(data=centers, aes(long, lat, label=state), color='white') +
  labs(title = 'Longitud promedio de las descripciones largas') +
  theme(legend.position='none') +
  coord_quickmap()

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
states_social <- states_df_narr %>%
  group_by(region, state, avg_sightings, population, income, illiteracy,
           life_exp, murder, hs_grad, frost, area, avg_sightings_per_capita,
           mean_long_desc_len) %>%
  summarise %>% ungroup %>%
  mutate(sight_per_illit = avg_sightings / (population * (illiteracy/100)))
# head(states_social)
states_social_plot <- rbind(
    data.frame(id='illiteracy', state= states_social$state,
          avg_sightings=states_social$avg_sightings, y=states_social$illiteracy),
    data.frame(id='murder', state= states_social$state, 
               avg_sightings=states_social$avg_sightings, y=states_social$murder),
    data.frame(id='life_exp', state= states_social$state,
               avg_sightings=states_social$avg_sightings, y=states_social$life_exp),
    data.frame(id='hs_grad', state= states_social$state,
               avg_sightings=states_social$avg_sightings, y=states_social$hs_grad)
  ) %>%
  filter(!is.na(y)) %>%
  group_by(id) %>%
  mutate(y = y/max(y)) # Normalizamos para comparar
# head(states_social_plot)
ggplot(states_social_plot, aes(avg_sightings, y)) +
  geom_text(aes(label=state)) +
  geom_smooth(method='loess') +
  facet_wrap(~ id)

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
parcial <- ufo[-long_vars] %>% 
  filter(date_time >= '2014-01-01' & date_time <= '2014-12-31') %>%
  group_by(state) %>%
  summarise(avistamientos = n()) %>%
  left_join(centers) %>%
  filter(!is.na(long) & !is.na(lat)) %>%
  data.frame
ggplot(mapping=aes(long,lat)) +
  geom_polygon(data=states_df, aes(group=group), fill='grey') +
  geom_point(data=parcial, aes(size=avistamientos)) +
  theme_nothing(legend=TRUE) +
  coord_quickmap()

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
library(geoR)
spat <- as.geodata(parcial, coords.col = 3:4, data.col = 2)
v_emp <- variog(spat, max.dist = 50)
v_emp_df <- data.frame(v_emp[c('u','v','n')])
names(v_emp_df) <- c('dist','gamma','np')
ggplot(v_emp_df, aes(dist, gamma)) +
  geom_point() +
  geom_line() +
  geom_text(aes(label=np), vjust=-0.5) +
  ylim(0,64000) +
  labs(title='Variograma empírico (los números son la población)',
       x = 'Distancia', y = 'Variograma (gamma)')
v_fit <- variofit(v_emp,  cov.model='exponential', ini.cov.pars = c(40000,20), nugget = T)
#v_fit

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
spat.grid <- expand.grid(long=seq(min(states_df$long),max(states_df$long), len = 200),
                         lat=seq(min(states_df$lat),max(states_df$lat), len = 200))
krig <- krige.conv(spat, locations=spat.grid, krige=krige.control(obj.model=v_fit))
krig_df <- data.frame(spat.grid, pred=krig$predict)
states_df2 <- states_df %>%
  dplyr::select(long, lat, group) 
library(sp)
s <- SpatialPoints(spat.grid)
polys <- list()
for(i in unique(states_df2$group)){
  polys[[i]] <- Polygon(states_df2[states_df2$group==i,c('long','lat')])
}
plist <- Polygons(polys, ID = 'group')
p <- SpatialPolygons(list(plist))

idx_in <- which(!is.na(sp::over(s,p)))

ggplot(mapping=aes(long,lat)) +
  geom_raster(data=krig_df[idx_in,], aes(fill=pred)) +
  geom_path(data=states_df2, aes(group=group)) +
  geom_text(data=parcial, aes(size=avistamientos, label=state)) +
  scale_fill_gradientn(colours = (brewer.pal(7,'YlOrRd'))) +
  scale_size_continuous(range = c(1,10)) +
  theme_nothing(legend = T) +
  coord_quickmap()

#############################################################################
# GDELT
#############################################################################

## ----, message=FALSE, warning=FALSE--------------------------------------
gdelt_conteos <- read.csv('output/conteos_gdelt_full.psv', header = T, sep = '|')
x <- data.frame(t(gdelt_conteos)) %>%
  format(scientific = F)
names(x) <- 'valor'
x$valor <- ifelse(x$valor == as.integer(x$valor), as.integer(x$valor), round(as.numeric(x$valor), 2))
gdelt_nulls <- x
kable(gdelt_nulls)

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
countrynames <- read.table('gdelt/etc/countrycodes.psv', header = F, quote = '', sep = '|',
                           col.names = c('actor1countrycode','country'))
gdelt_first <- read.csv('output/first_event_per_actor1countrycode_full.psv', header = T, sep = '|') %>%
  left_join(countrynames)

gdelt_first %>%
  group_by(sqldate) %>%
  summarise(country = paste(sort(country), collapse = ', ')) %>%
  filter(country != '') %>%
  kable

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
gdelt_monthyear <- read.csv('output/monthyear_actor1countrycode_stats_full_countryname.psv', header = T, sep = '|')

gdelt_monthyear %>%
  rename(country = actor1countryname) %>%
  group_by(country) %>%
  summarise(tot_numevents = sum(numevents),
            avg_numevents = mean(numevents),
            avg_goldsteinscale = mean(goldsteinscale),
            tot_nummentions = sum(nummentions),
            avg_nummentions = mean(nummentions),
            tot_numsources = sum(numsources),
            avg_numsources = mean(numsources),
            avg_avgtone = mean(mean_avgtone)
            ) %>%
  format(digits = 2, scientific = F) %>%
  kable

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
# Filtramos y construimos la fecha
x1 <- gdelt_monthyear %>%
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
#dim(gdelt_ts)

x <- cor(gdelt_ts[-1])[,'MEX']
#x <- factor(x, levels = levels(x)[order(x)])
cor_mex <- data.frame(country = names(x), cor_mex = as.numeric(x)) %>%
  arrange(desc(cor_mex)) %>%
  left_join(countrynames, by = c('country'='actor1countrycode'))
cor_mex$country <- factor(factor(cor_mex$country),
                          levels = cor_mex$country[order(cor_mex$cor_mex)],
                          ordered = T)

# Ejemplo: Gráficas de ts
x2 <- filter(x1, actor1countrycode %in% c('MEX','USA','IRQ','HRV')) %>%
  group_by(actor1countrycode) %>%
  mutate(numevents_norm = numevents / max(numevents))


## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
ggplot(cor_mex, aes(country, cor_mex)) +
  geom_bar(stat='identity') +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
ggplot(x2, aes(date, numevents_norm)) +
  geom_line() +
  facet_wrap(~ actor1countryname)

## ----, message=FALSE, warning=FALSE, echo=FALSE--------------------------
dist_ts <- as.dist(1 - cor(gdelt_ts[-1]))
hclus_1 <- hclust(dist_ts, method = 'complete')
plot(hclus_1, main='5 grupos', xlab='')
hclus_2 <- rect.hclust(hclus_1, k=5)

plot(hclus_1, main='10 grupos', xlab='')
hclus_2 <- rect.hclust(hclus_1, k=10)

plot(hclus_1, main='30 grupos', xlab='')
hclus_2 <- rect.hclust(hclus_1, k=30)

#############################################################################
# GUARDAR INFO
#############################################################################

#save.image('entregable/datos_reporte.Rdata')
