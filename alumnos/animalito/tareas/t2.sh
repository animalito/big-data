#!/bin/bash

#### sed

# Elimina los headers repetidos con sed en los archivos UFO
< UFO-Nov-Dic-2014.tsv sed 's/.Date/p/g' > pruebita.tsv
# O 
sed -i 's/.Date/p/g' UFO-Nov-Dic-2014.tsv

# Describe estadisticamente los tiempos de observacion (cut, grep, sed, awk, etc)


#### R-python

# Reproducir el ejercicio de awk de la mediana y sd con Python y R usando redireccion y ejecutables. (En vez de awk)
