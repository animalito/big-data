library(Hmisc)
library(tidyr)
library(dplyr)
library(ggplot2)

tabla <- read.delim("~/proyecto/big-data/alumnos/AndyGT/proyecto_1/tabla.txt", stringsAsFactors=FALSE)

# preparando datos (registro con fecha y ciudad de avistamiento)
datos <- tabla %>%
  separate(col=Date...Time, into=c("month","day","year","time"),
           regex=" ",remove=F,extra="drop")%>%
  mutate(date= paste(month, day, year, sep ='/'),
         state = State, 
         date = as.Date(date, format='%m/%d/%y')) %>%
  select(date, state )

# quitamos los que no tienen estado 
#datos <- datos[complete.cases(datos),]

# duración
duracion <-datos%>%
  group_by(state,date)%>%
  arrange(state, date)%>%
  summarise(reportes =n())%>%
  mutate(freq = reportes/sum(reportes), 
         prev = lag(date),
         dif = (date -prev))



# solo nos interesa el acumulado 
duracion$acum <- sequence(rle(as.character(duracion$dif))$lengths)
#ordenamos 
duracion_1 <-duracion[with(duracion, order(-acum)), ]

# mayor racha de avistamiento por estado
result <- duracion_1 %>%
  group_by(state) %>%
  top_n(n=1)

 
head(result, 15)



head(duracion_1)


fechas <- datos['date']
fechas <- as.Date(fechas, format='%y/%m/%d')
class(fechas)
dias <- weekdays(fechas, abbreviate = FALSE)
unique(dias)
dias <- as.factor(dias)
summary(dias)

Domingo 
