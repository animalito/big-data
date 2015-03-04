#!/bin/bash
#TAREA 1
# Descarga el libro de The Time Machine de H. G. Wells, convertirlo a minúsculas, extraer las palabras, ordenarlas, eliminar duplicados y contarlos, ordenar de mayor a menor y luego mostrar el top 10.

< pg35.txt tr "[:upper:]" "[:lower:]" | grep -oE '\w+' | sort | uniq -c | sort -t $' ' -nrk 1 | head -10 > out.txt

# Pegar mediana, desv estandar en un mismo archivo y aplicarselo a diferentes columnas.
# Modificar la mediana para que no necesite usar el asort y que use entonces un sort (no gawk)
# Completar el ejercicio que esta en el lecture 2 con ufos

