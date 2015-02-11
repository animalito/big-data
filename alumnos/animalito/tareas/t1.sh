#!/bin/bash

# Descarga el libro de **The Time Machine** de *H. G. Wells*, convertirlo a minúsculas, extraer las palabras, ordenarlas, eliminar duplicados y contarlos, ordenar de mayor a menor y luego mostrar el top 10. *una sola linea*

curl -s http://www.gutenberg.org/cache/epub/35/pg35.txt > time_machine.txt

< time_machine.txt | tr '[:upper:]' '[:lower:]' | grep -Eo '\w+' | sort | uniq -c | sort -rn | head -10 > wibbly_wobbly_timey_wimey_stuff.txt

# Pegar mediana, desv estandar en un mismo archivo y aplicarselo a diferentes columnas.

# Modificar la mediana para que no necesite usar el asort y que use entonces un sort (no gawk)

# Completar el ejercicio que esta en el lecture 2 con ufos
