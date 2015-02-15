#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
LECTURE="${DIR}/../../../lecture_2/awk_sed"

#### sed

# Elimina los headers repetidos con sed en los archivos UFO
< UFO-Nov-Dic-2014.tsv sed 's/.Date/p/g' > pruebita.tsv
# O 
sed -i 's/.Date/p/g' UFO-Nov-Dic-2014.tsv

# Describe estadisticamente los tiempos de observacion (cut, grep, sed, awk, etc)

< UFO-Nov-Dic-2014.tsv | cut -d$'\t' -f5 | egrep ".[0-9]" | egrep -v 'i only saw|Watched about' | sed 's/[<>+~]//g' | sed 's/.[-]//g' | sed '/[:]/d' | sed '/[0-9]$/d' | sed '/[\/]/d' | sed '/every/d;/to/d' | sed 's/\?//g' | sed 's/ seconds/\/60/g;s/ minutes//g;s/ hours/\*60/g;s/ second/\/60/g;s/ minute//g;s/hour/\*60/g;s/ min//g;s/min//g;s/ milliseconds/\/6000/g;s/ seconts/\/60/g;s/ //g' | bc -l | awk -f ../tareas/utils.gawk

#### R-python

# Reproducir el ejercicio de awk de la mediana y sd con Python y R usando redireccion y ejecutables. (En vez de awk)

< UFO-Nov-Dic-2014.tsv | cut -d$'\t' -f5 | egrep ".[0-9]" | egrep -v 'i only saw|Watched about' | sed 's/[<>+~]//g' | sed 's/.[-]//g' | sed '/[:]/d' | sed '/[0-9]$/d' | sed '/[\/]/d' | sed '/every/d;/to/d' | sed 's/\?//g' | sed 's/ seconds/\/60/g;s/ minutes//g;s/ hours/\*60/g;s/ second/\/60/g;s/ minute//g;s/hour/\*60/g;s/ min//g;s/min//g;s/ milliseconds/\/6000/g;s/ seconts/\/60/g;s/ //g' | bc -l | ../tareas/summary.r

