#! /bin/bash
# Arg 1: path absoluto carpeta con info
# Arg 2: path absoluto a unzip_gdelt.sh

find $1 \
| grep .zip \
| while read f
do
    echo "\copy dirty.gdelt_full FROM PROGRAM '$2 $f' WITH DELIMITER '|';"
done
