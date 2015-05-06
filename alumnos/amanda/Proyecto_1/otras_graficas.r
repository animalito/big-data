# Cargamos la información histórica de avistamientos}
ruta_archivo <- "C:/Users/Amanda/Documents/archivos_gran_escala/Proyecto_1/datos_UFO.txt"
df_UFO1 <- read.table(ruta archivo, header = TRUE)

# Gráfica de avistamientos por estado
tabla_1 <- df_UFO1 %>%
  group_by(State) %>%
  summarise(no = n())
ggplot(tabla_1, aes(x=State, y=no)) +
  geom_bar(aes(fill=State), stat="identity")
  guides(fill = FALSE) +
  xlab("") + ylab("") +
  theme(axis.text.x = element_text(angle = 90, size = 8))  

# Gráfica de avistamientos por mes
tabla_2 <- df_UFO1 %>%
  group_by(mes) %>%
  summarise(no = n())
ggplot(tabla_2, aes(x=mes, y=no)) +
  geom_bar(aes(fill=mes), stat="identity") +
  guides(fill = FALSE) +
  xlab("") + ylab("") +
  scale_x_discrete(limits=c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"))

# Gráfica de avistamientos por día de la semana
tabla_3 <- df_UFO1 %>%
  group_by(dia_sem) %>%
  summarise(no = n())
ggplot(tabla_3, aes(x=dia_sem, y=no)) +
  geom_bar(aes(fill=dia_sem), stat="identity") +
  guides(fill = FALSE) +
  xlab("") + ylab("") +
  theme(axis.text.x = element_text(angle = 90, size = 12))  

