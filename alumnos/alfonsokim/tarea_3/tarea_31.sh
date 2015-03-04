#!/bin/bash

## Tarea 3.1: Analisis de tiempos de avistamiento usando AWK
## tr '[:upper:]' '[:lower:]':  convierte todo a minusculas
## sed 's/few/10/g': Algunas lineas tienen few seconds, lo cambio subjetivamente por 10
## sed 's/~\|+\|<\|>\|\?//g': Quito tilde, signo de mas, menor y mayor
## Cada awk tiene su descripcion independiente 

## Las lineas que no tienen ningun patron identificable se guardan en
## un archivo "raros.txt"
rm -f raros.txt

cut -d$'\t' -f5 ../data/UFO-Nov-Dic-2014.tsv \
        | tr '[:upper:]' '[:lower:]' \
	    | sed 's/few/10/g' \
        | sed 's/~\|+\|<\|>\|\?//g' \
	    | awk -f rangos.awk \
        | awk -f unidades.awk \
        | awk -f analisis.awk

echo "See raros.txt for manual analysis"

