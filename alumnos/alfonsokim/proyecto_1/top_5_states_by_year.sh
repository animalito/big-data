#!/bin/bash

## Este script obtiene los anios con mas observaciones, agrupados por pais.
## Para hacerlo se usa un script de AWK

cut -d$'|' -f1,3 data.csv | grep -Ev NA | awk -f states_by_year.awk | sort -t "|" -k 1,1 -k 2,2 | uniq -c | sort -r | head -10
