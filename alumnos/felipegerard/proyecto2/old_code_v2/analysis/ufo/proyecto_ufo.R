
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(ggmap)
library(RColorBrewer)

# Leemos la base que limpiamos en postgres
ufo <- read.table('output/ufo_usa.psv', header = T, sep = '|', quote = "", stringsAsFactors = F, fill = T,
                  colClasses = rep('character',18))

################################################################
# Limpieza aparte de lo de postgres
################################################################

data.frame(sapply(ufo,class))
for(x in c('year','month','day','weekday','number','seconds')){
  ufo[[x]] <- as.numeric(ufo[[x]])
}
ufo <- filter(ufo, nchar(origin) < 20)  %>% # Algunos renglones venían mal
  mutate(id = row_number())
dim(ufo)

################################################################
# Descripción de los datos (la limpieza ya fue en PostgreSQL)
################################################################

dim(ufo)
cols <- data.frame(columna=names(ufo), tipo=sapply(ufo, class), row.names = NULL)
cols
head(ufo %>% select(-summary, -long_description, -description_url))
tail(ufo %>% select(-summary, -long_description, -description_url))
ufo$summary[1]
ufo$long_description[1]
summary(ufo)

# Ojo. En columnas como duration, las dejamos para ver cuándo y por qué son nulas number, units, seconds, etc



################################################################
# Análisis
################################################################

long_vars <- c(15,17,18) # Columnas de texto largas

############ ¿Primer avistamiento en cada estado? ¿Primer avistamiento de cada forma?
################################################################

# Primer avistamiento por estado
ufo %>%
  filter(!is.na(year)) %>%
  group_by(state) %>%
  arrange(state, year) %>%
  filter(row_number() == 1) %>%
  dplyr::select(state, date_time, city, shape, duration, seconds, posted)

# Primer avistamiento por forma
ufo %>%
  filter(shape != '') %>%
  group_by(shape) %>%
  arrange(shape, year) %>%
  filter(row_number() == 1) %>%
  dplyr::select(state, date_time, city, shape, duration, seconds, posted)

############ ¿Promedio de entre avistamientos, por mes, por año? ¿Por estado?
################################################################

# Promedio mensual de avistamientos
ufo %>%
  filter(date_time != '') %>%
  group_by(year, month) %>%
  summarise(count = n()) %>%
  ungroup %>%
  summarise(monthly_mean = mean(count))

# Avistamientos totales por mes
monthly_sightings <- ufo %>%
  filter(date_time != '', year < 2015) %>%
  group_by(month) %>%
  summarise(count = n()) %>%
  arrange(month)
monthly_sightings
ggplot(monthly_sightings, aes(month, count)) +
  geom_bar(stat='identity')

# Promedio anual de avistamientos
ufo %>%
  filter(date_time != '') %>%
  group_by(year) %>%
  summarise(count = n()) %>%
  ungroup %>%
  summarise(yearly_mean = mean(count))

# Avistamientos totales por año
yearly_sightings <- ufo %>%
  filter(date_time != '', year < 2015) %>% # Este año no está completo
  group_by(year) %>%
  summarise(count = n()) %>%
  arrange(year)
yearly_sightings
ggplot(yearly_sightings, aes(year,count)) +
  geom_line() +
  geom_point()

############ ¿Cuál estado tiene mayor varianza?
################################################################

# Varianza entre avistamientos mensuales
monthly_state_var <- ufo %>%
  filter(state != '') %>%
  group_by(state, year, month) %>%
  summarise(count = n()) %>%
  group_by(state) %>%
  summarise(monthly_sd = sd(count),
            monthly_mean = mean(count),
            monthly_sd_mean_ratio = monthly_sd/monthly_mean,
            count = sum(count)) %>%
  arrange(desc(monthly_sd_mean_ratio)) # Si no, los estados más grandes tienden a tener más varianza (plot abajo)
monthly_state_var
ggplot(monthly_state_var, aes(count, monthly_sd)) +
  geom_point()
ggplot(monthly_state_var, aes(count, monthly_sd_mean_ratio)) +
  geom_point()



############ ¿Existen olas temporales? ¿Existen olas espacio-temporales?
################################################################

## Temporal por año
ggplot(yearly_sightings, aes(year, count)) +
  geom_line() +
  geom_point()

# Por posted
yearly_posted <- ufo %>%
  filter(posted != '') %>%
  mutate(year_posted = year(posted)) %>%
  group_by(year_posted) %>%
  summarise(count = n())
yearly_posted
ggplot(yearly_posted %>% filter(year_posted < 2015), aes(year_posted, count)) +
  geom_line() +
  geom_point()

## Espacial

# Por estado
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

# En total vs población en 1975
state_info <- state.x77 %>%
  as.data.frame %>%
  mutate(region = tolower(rownames(state.x77)))
names(state_info) <- tolower(names(state_info))
names(state_info)[c(4,6)] <- c('life_exp', 'hs_grad')
head(state_info)
state_sightings <- ufo %>%
    filter(state != '') %>%
    group_by(state) %>%
    summarise(sightings = n())
us_states <- map_data('state')
states_df <- us_states %>% # el fortify no es necesario
  left_join(state_abbr) %>%
  left_join(state_sightings) %>%
  left_join(state_info) %>%
  mutate(sightings_per_capita = sightings / population)
head(states_df)
# centroids <- group_by(states_df, state) %>%
#   mutate(long=mean(long), lat=mean(lat))
centers <- data.frame(state.center, state=state.abb)
names(centers) <- c('long','lat','state')
ggplot(states_df) +
  geom_polygon(aes(long,lat,group=group, fill=sightings_per_capita)) +
  geom_text(data=centers, aes(long, lat, label=state), color='grey') +
  labs(title = 'Sightings per capita') +
  theme_nothing()

# En bloques de 50 años vs población de 1975
state_sightings_block <- ufo %>%
  filter(state != '') %>%
  mutate(block = cut(year, c(1800,seq(1950,2020,10)), dig.lab = 4)) %>%
  group_by(state, block) %>%
  summarise(sightings = n())
states_df_block <- fortify(us_states) %>%
  left_join(state_abbr) %>%
  left_join(state_sightings_block) %>%
  left_join(state_info) %>%
  mutate(sightings_per_capita = sightings / population)
ggplot(states_df_block) +
  geom_polygon(aes(long,lat,group=group, fill=sightings_per_capita)) +
  geom_text(data=centers, aes(long, lat, label=state), color='grey', size = 3) +
  facet_wrap(~ block) +
  labs(title = 'Sightings per capita') +
  theme(legend.position='none')

############ ¿Narrativas parecidas? ¿Cómo está relacionado con la geografía?
################################################################

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
  labs(title = 'Mean length of narratives')

# ¿Con características sociales?

states_social <- states_df_narr %>%
  group_by(region, state, sightings, population, income, illiteracy,
           life_exp, murder, hs_grad, frost, area, sightings_per_capita,
           mean_long_desc_len) %>%
  summarise %>% ungroup %>%
  mutate(sight_per_illit = sightings / (population * (illiteracy/100)))
head(states_social)
states_social_plot <- rbind(
    data.frame(id='illiteracy', state= states_social$state,
          sightings=states_social$sightings, y=states_social$illiteracy),
    data.frame(id='murder', state= states_social$state, 
               sightings=states_social$sightings, y=states_social$murder),
    data.frame(id='life_exp', state= states_social$state,
               sightings=states_social$sightings, y=states_social$life_exp),
    data.frame(id='hs_grad', state= states_social$state,
               sightings=states_social$sightings, y=states_social$hs_grad)
  ) %>%
  filter(!is.na(y)) %>%
  group_by(id) %>%
  mutate(y = y/max(y)) # Normalizamos para comparar
head(states_social_plot)
ggplot(states_social_plot, aes(sightings, y)) +
  geom_text(aes(label=state)) +
  geom_smooth(method='loess') +
  facet_wrap(~ id)


############ Desarrolla un modelo predictivo.
################################################################
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

states_df <- map_data('state')
centers <- data.frame(state.center, state=state.abb)
names(centers) <- c('long','lat','state')

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
  theme_nothing(legend=TRUE)

### Haremos krigging
library(gstat)
library(sp)
#library(spatstat) detach('package:spatstat', unload=T)
# Quitamos la tendencia
lm_parcial <- lm(avistamientos ~ long + lat, data = parcial)
parcial$res_hat <- lm_parcial$residuals
ggplot(mapping=aes(long,lat)) +
  geom_polygon(data=states_df, aes(group=group), fill='grey') +
  geom_point(data=parcial, aes(size=res_hat)) +
  theme_nothing(legend=TRUE)

# Variograma
spat <- parcial
coordinates(spat) = ~ long + lat
emp_variog <- variogram(res_hat ~ 1, data=spat)
ggplot(emp_variog, aes(dist, gamma)) +
  geom_point() +
  geom_line() +
  geom_text(aes(label=np), vjust=-0.5) +
  ylim(0,30000)
fit_variog <- fit.variogram(emp_variog,
                            vgm(psill = 1,'Sph',range = 10, nugget = 0.01),
                            fit.method = 2)
plot(emp_variog,fit_variog)

# Kriging
library(geoR)
spat <- as.geodata(parcial, coords.col = 3:4, data.col = 5)
v_emp <- variog(spat, max.dist = 50)
v_emp_df <- data.frame(v_emp[c('u','v','n')])
names(v_emp_df) <- c('dist','gamma','np')
ggplot(v_emp_df, aes(dist, gamma)) +
  geom_point() +
  geom_line() +
  geom_text(aes(label=np), vjust=-0.5) +
  ylim(0,64000)
v_fit <- variofit(v_emp,  cov.model='exponential', ini.cov.pars = c(40000,20), nugget = T)
v_fit
spat.grid <- expand.grid(long=seq(min(states_df$long),max(states_df$long), len = 100),
                         lat=seq(min(states_df$lat),max(states_df$lat), len = 100))
krig <- krige.conv(spat, locations=spat.grid, krige=krige.control(obj.model=v_fit))
krig_df <- data.frame(spat.grid, pred=krig$predict)
ggplot(mapping=aes(long,lat)) +
  geom_raster(data=krig_df, aes(fill=pred)) +
  geom_path(data=states_df, aes(group=group)) +
  geom_point(data=parcial, aes(size=avistamientos), shape='o') +
  scale_fill_gradientn(colours = rev(brewer.pal(7,'YlGnBu'))) +
  scale_size_continuous(range = c(1,10)) +
  theme_nothing(legend = T)



# Ejercicio
# aux <- ufo[-long_vars] %>% 
#   filter(date_time >= '2014-01-01' & date_time <= '2014-12-31') %>%
#   group_by(state) %>%
#   left_join(centers)
# partial <- aux %>%
#   mutate(long = long + rnorm(nrow(aux),0,1),
#          lat = lat + rnorm(nrow(aux),0,1),
#          date_color = as.numeric(as.Date(date_time) - as.Date("2014-01-01 00:00:00")))
# partial <- aux
# partial$long <- partial$long + rnorm(nrow(aux),0,1)
# partial$lat <- partial$lat + rnorm(nrow(aux),0,1)
# partial$date_color <- as.numeric(as.Date(partial$date_time) - as.Date("2014-01-01 00:00:00"))
# ggplot() +
#   geom_polygon(data=states_df, aes(long, lat, group=group), fill='grey') +
#   geom_jitter(data=partial, aes(long,lat,color=date_color)) +
#   geom_text(data=centers, aes(long,lat,label=state)) +
#   theme_nothing()





