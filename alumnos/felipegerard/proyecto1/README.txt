# Proyecto 1. UFOs

### NOTA 1: Los comandos entre comillas es lo que hay que correr. Los demas son auxiliares usadas en los scripts entrecomillados.
### NOTA 2: Los archivos *.result tienen los resultados de los diversos ejercicios.
 
# 0. Bajar información
  * 'get_urls.R': Consigue las URLs de la información
  * 'instancias_aws': Direcciones de las instancias de AWS
  * 'instala_R.sh': Instala R en las máquinas de AWS
  * 'instala_rvest.sh': Instala el paquete rvest en las máquinas de AWS
  * 'get_data_aws.sh': Descarga la información en paralelo a las máquinas de AWS

# 1. Observaciones totales
  * 'obs_totales.sh > obs_totales.result': Calcula las observaciones totales de la base

# 2. Top 5 estados 
  * 'top_5_estados.sh > ranking_estados.result': Calcula el ranking de avistamientos de los estados (para top 5 agregar ' | head -5')
  * 'top_5_estados_anio.sh > top_5_estados_anio.result': Calcula el top 5 de avistamientos de los estados por año

# 3. Rachas por estado
  * 'racha_por_estado.sh > rachas_por_estado.result': Calcula la racha más larga de cada estado
    ** info_racha_por_estado.sh: Consigue la información de rachas de AWS
    ** info_racha_por_estado.R: Calcula las diferencias en las fechas
    ** sumariza_racha_por_estado.sh: Calcula las rachas
  * 'racha_pais.sh > rachas_pais.result': Calcula un ranking de las rachas en el país
    ** info_racha_pais.sh: Consigue la información de rachas de AWS
    ** info_racha_pais.R: Calcula las diferencias en las fechas
    ** sumariza_racha_pais.sh: Calcula las rachas

# 4. Top meses y días
  * 'top_meses.sh > ranking_meses.result': Calcula el ranking de avistamientos de los meses
  * 'top_dias_semana.sh > ranking_dias.result': Calcula el ranking de avistamientos de los días de la semana
    ** dia_semana.R: Convierte las fechas a días de la semana

# 5. Gráficas de series de tiempo
  * 'info_plot.sh > plot.data': Es idéntico a info_racha_por_estado.sh. Baja la información de AWS a la máquina local
  * plot_ufo.R: Grafica en la consola la serie de tiempo de un estado o del país. Requiere 'txtplot' en R
    ** Ejemplos:
      1.
          $ ./plot_ufo.R
	  > Proporciona un estado...
          $ TX
          > ... Gráfica de avistamientos en Texas
      2.
          $ ./plot_ufo.R
	  > Proporciona un estado...
          $ EUA
          > ... Gráfica de avistamientos en EUA
      3.
          $ ./plot_ufo.R
          > Proporciona un estado...
	  $ 
          >... Gráfica de avistamientos en EUA
      4.
          $ echo "NY" | ./plot_ufo.R
	  > ... Gráfica de avistamietnos en NY          
