#! /bin/bash
# $1: ruta de entrada de datos psv (ufo_psv)
# $2: ruta de salida de datos psv con id (ufo_psv_id)

find $1 \
| grep ndxe \
| parallel -j8 --progress \
"< {} awk -F'|' 'BEGIN {OFS=\"|\"} {if(NR==1){\$9=\"ID\"; \$10=\"Base\"}else{\$9=NR-1; \$10=\"{/.}\"}; print}' \
> $2/{/.}.ufo_psv_id"


