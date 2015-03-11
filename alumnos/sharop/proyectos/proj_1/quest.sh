#!/usr/bin/env sh

###Cuanto 
echo "¿Cuántas observaciones totales?"
parallel -N1 --nonall --slf instancias.azure "awk 'END{print NR}' \$(ls ~/out/part_frame*)" | awk '{ s+=$1} END { print s} ' 
echo "¿Cuál es el top 5 de estados?"
cat noc.tsv | cut -d$'  ' -f3 |tr '[:lower:]' '[:upper:]' | sed 's/\//g'|sed '/^$/d' |sort -b -t $' ' -k 1 |uniq -c | sort -gr | head -10
echo "¿Cuál es el top 5 de estados por año?"
cat noc.tsv | cut -d$'\t' -f1,3 |tr '[:lower:]' '[:upper:]' | awk -F/ '{ print $3 }' | sed 's/\t/ /g' |awk '{ print $1 "\t " $3 }'|sed '/  *$/d'|sort -b -k 2 | uniq -c | sort -rg | head -10
echo "¿Cuál es la racha más larga en días de avistamientos en un estado?"

echo "¿Cuál es la racha más larga en días de avistamientos en el país?"

echo "¿Cuál es el mes con más avistamientos? ¿El día de la semana?"
 cat  noc.tsv | cut -d$'\t' -f1,3 |tr '[:lower:]' '[:upper:]' | awk -F/ '{ print $1 " " $3 }' | sed 's/\t/ /g' |awk '{ print $1 "\t" $4 }' | sort -rk 1|sed '/.\t  $/d' | uniq -c | sort -rg  |head
echo "Dia de la semana"
icat  noc.tsv | cut -d$'\t' -f1,3 |tr '[:lower:]' '[:upper:]' | awk -F/ '{ print $1 " " $3 }' | sed 's/\t/ /g' |awk '{ print $2 "\t" $4 }' | sort -rk 1|sed '/.\t  $/d' | uniq -c | sort -rg  |head
#cat noc.tsv | cut -d$'	' -f3 |sed 's/\//g'|sed '/^$/d' |sort -b -t $'	' -k 1 |uniq -c | sort -g
#cat noc.tsv | cut -d$'	' -f3 |tr '[:lower:]' '[:upper:]' | sed 's/\//g'|sed '/^$/d' |sort -b -t $'	' -k 1 |uniq -c | sort -gr | head -10 
