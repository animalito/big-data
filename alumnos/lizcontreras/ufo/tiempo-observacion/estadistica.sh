#!/bin/bash
# Unir los datos de noviembre y diciembre
cat UFO-Nov-2014.tsv UFO-Dic-2014.tsv > ufo-nov-dic.tsv

#Eliminar los headres
sed -i 's/.Date/p/g' ufo-nov-dic.tsv

#Describe estadisticamente los tiempos de observacion

#Los datos se convierten en segundos
cat ufo-nov-dic.tsv | cut -f5 | sed 's/~//' | sed 's/+//' | sed 's/[^0-9]*//' | sed '/./!d' | sed 's/-/ /' | sed 's/\// /' | grep "[sec|min|hour]" | awk '$2 ~ /[0-9]/ {$1 = int(($1+$2)/2); $2 = $3; $3 = ""} $2 ~ /mil/ {$3 = int($1/1000); print $3} $2 ~ /sec/ {$3 = int($1); print $3} $2 ~ /min/ {$3 = int($1*60); print $3} $2 ~ /h/ {$3 = int($1*60*60); print $3}'>ufo-tiempo-seg.tsv

#Media, maximo, minimo

cat ufo-tiempo-seg.tsv | awk '{FS="|"} {if(min==""){min=max=$1}; if($1>max){max=$1}; if($1<min){min=$1}; total+=$1; count++} END {print "media = " int(total/count), ";minimo = " min, ";maximo = " max}'>estadisticas.txt

#Mediana
cat ufo-tiempo-seg.tsv | sort -n | awk '{FS="|"} {count[NR] = $1} END {if(NR % 2){print "mediana = " count[(NR + 1)/2]} else{print "mediana = " int((count[NR/2] + count[(NR/2) + 1])/2)}}'>>estadisticas.txt

#Desviacion estandar y varianza
cat ufo-tiempo-seg.tsv | awk '{sum+=$1; sumsq+=$1*$1} END{print "desviacion estandar = " int(sqrt(sumsq/NR - (sum/NR)**2)) " ;varianza = " int((sumsq/NR - (sum/NR)))}'>>estadisticas.txt
