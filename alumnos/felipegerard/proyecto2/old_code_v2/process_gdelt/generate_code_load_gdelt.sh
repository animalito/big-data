#! /bin/bash

find $1 \
| while read f;
do
    echo "\copy dirty.gdelt_mex FROM $f WITH DELIMITER '|';"
done
