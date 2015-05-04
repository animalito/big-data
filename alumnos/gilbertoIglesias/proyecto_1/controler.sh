echo -n "Observaciones totales:" > resultados.txt
python  functionality.py conteo_global  >> resultados.txt
echo "Top 5 estados:" >> resultados.txt
python  functionality.py top_5_estados | sort -d | uniq -c | sort -n -r | head -n 5 >> resultados.txt
echo "Top 5 estados en el año $2:" >> resultados.txt
python  functionality.py top_5_estados_x_anio $2 | sort -d | uniq -c | sort -n -r | head -n 5 >> resultados.txt
echo "Racha mas larga de avistamientos en $1:" >> resultados.txt
python functionality.py racha_larga_estado $1 | sort -n | uniq | sort -n | python functionality.py cuenta_racha >> resultados.txt
echo "Racha mas larga de avistamientos en el pais:" >> resultados.txt
python functionality.py racha_larga_pais | sort -n | uniq | sort -n | python functionality.py cuenta_racha >> resultados.txt
echo "Mes con mas avistamientos:" >> resultados.txt
python functionality.py mes_mas_avistamientos | sort -n | uniq -c | sort -n -r >> resultados.txt
echo "Dia con mas avistamientos:" >> resultados.txt
python functionality.py dia_mas_avistamientos  | sort -n | uniq -c | sort -n -r >> resultados.txt
echo "Inicio serie espacio temporal:" >> resultados.txt
python functionality.py dias_observaciones_completo  | sort  | uniq -c | sed 's/^\ *//' | sed 's/\ /,/' | ./estadisticas.r 
mv Rplots.pdf grafica_serie_todos.pdf
echo "Inicio serie espacio temporal del estado $1:" >> resultados.txt
python functionality.py dias_observaciones_estado $1  | sort  | uniq -c | sed 's/^\ *//' | sed 's/\ /,/' | ./estadisticas.r 
mv Rplots.pdf grafica_serie_estado.pdf
