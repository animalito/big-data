
library(dplyr)
library(ggplot2)
library(lubridate)

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
  geom_line() +
  geom_point()

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


############ ¿Narrativas parecidas?
################################################################
############ ¿Cómo está relacionado con la geografía?
################################################################
############ ¿Con características sociales?
################################################################
############ Desarrolla un modelo predictivo.
################################################################










