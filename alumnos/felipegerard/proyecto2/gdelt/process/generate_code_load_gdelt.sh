#! /bin/bash
# $1: ruta de los datos de GDELT de Mexico

find $1 \
| while read f;
do
    echo "\copy dirty.gdelt_mex FROM $f WITH DELIMITER '|';"
done
