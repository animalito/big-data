#!/bin/bash
#Luis M. Román García
#Script para leer un archivo en html con una y devolverla en formato csv.

file=$1
lines=`wc -l $file`
lines1=${lines/.*}
for i in $(seq $lines1);
do
echo $i
cat $file | scrape -b -e '//td' | xml2json | jq '.' | grep '$t' | sed 's/^ *//;s/ *$//' | cut -c6- | /usr/bin/Rscript ./toCsv.R && cat test.json | jq -c {'date: .['$i'][0], city: .['$i'][1], state: .['$i'][2], shape: .['$i'][3],duration: .['$i'][4], posted: .['$i'][6]}'| /home/lgarcia/go/bin/json2csv -p -k date,city,state,shape,duration,posted |header -d >> globalFile.csv 
done
