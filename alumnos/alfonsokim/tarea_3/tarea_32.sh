#!/bin/bash

## Tarea 3.2: Analisis de tiempos de avistamiento usando python y encadenamiento

## Las lineas que no tienen ningun patron identificable se guardan en
## un archivo "raros.txt"
rm -f raros.txt

cut -d$'\t' -f5 ../data/UFO-Nov-Dic-2014.tsv \
	| python analisis_completo.py
