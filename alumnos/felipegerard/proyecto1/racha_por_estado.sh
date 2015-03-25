#! /bin/zsh

./info_racha_por_estado.sh \
| ./info_racha_por_estado.R \
| ./sumariza_racha_por_estado.sh \
| awk '/[A-Z][A-Z]/ {if(NR == 1){ print "Estado\tNR\tRacha\tInicio\tFin"; print }else{ print }}'

