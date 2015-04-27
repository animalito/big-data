#! /bin/bash

find ../datos/ufo_psv \
| grep ndxe \
| parallel -j8 --progress \
"< {} awk -F'|' 'BEGIN {OFS=\"|\"} {if(NR==1){\$9=\"ID\"; \$10=\"Base\"}else{\$9=NR-1; \$10=\"{/.}\"}; print}' \
> ../datos/ufo_psv_id/{/.}.ufo_psv_id"


