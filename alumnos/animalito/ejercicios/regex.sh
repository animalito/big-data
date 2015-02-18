#!/bin/bash

# Se pueden hacer extraccion, matcheo y validacion con expresiones regulares.

[0-2]?[1-9]|3[0-1]//[0][1-9]|[1][0-2]//


# Fecha en formato dd/mm/aaaa con anio de 1900 a 2100
#(0[1-9]|[1-2][0-9]|3[01])/0[1-9]|[1][0-2]/((19)|(20[0-9])|(2100))

# Correo electronico
#[a-z0-9_\.\-]{3,}@([a-z0-9\.]

# Como reconocemos los avistamientos en otro pais
# Estado tiene 2 caracteres Y en la ciudad aparece algo entre parentesis

# Seleccionar la linea que tiene EXACTAMENTE 5 digitos.
grep -E "^[0-9]{5}$" numbers.txt # que empiece es el ^, que termine la linea es $

# Cuantos javier o romina o andrea hay en names.txt
egrep "^(j|r|a)(a|o|n)" names.txt | sort | uniq -c

#AWK

# Pongo lo que no tenga columnas necesarias en un archivo y las que si en otro
awk 'BEGIN{ FS = "\t" }; { if(NF != 7){ print >> "UFO_fixme.csv"} \
else { print >> "UFO_OK.csv" } }' UFO-Nov-Dic-2014.tsv


# Sumo la primera columna, imprimo

awk ' { sum += $1 } END { print sum }' data.txt

grep -v "uno" data2.txt | awk -F'|' '{ sum += $1; sum2 += $2; mult += $2*$3 } END { print  sum1/NR, sum2/NR, mult/NR }' data2.txt

# awk no modifica el archivo sino que modifica el string que de ahi lee.

## Loops
for word in `cat UFO*.tsv`
do
echo $word
done
#no esta viendo el enter como una separacion 

## Ejecutemos el find sin el parallel

### Imprimimos linea por linea en stdout
find ../../../lecture_2/awk_sed --name "*.txt" 

# Ahora si ponemos una bandera cambia el salto de linea por un null, asi el comando que sigue sabe que el separador de la lista es null
find ../../../lecture_2/awk_sed --name "*.txt" -print0

## Parallel
# Contemos lineas en un archivote
cat ../../../lecture_2/parallel/1000000.txt | parallel --pipe wc -l | awk '{ sum += $1 } END {print sum }'


