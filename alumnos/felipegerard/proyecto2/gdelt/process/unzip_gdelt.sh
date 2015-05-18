#! /bin/bash
# $1: ruta de los archivos de GDELT

unzip -p $1 \
| tr '\t' '|' \
| awk -F '|' 'BEGIN {OFS = "|"} {if(NF==57){print $0, ""} else {print $0}}'
