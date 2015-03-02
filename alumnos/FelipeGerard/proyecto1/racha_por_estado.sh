#! /bin/zsh

echo "Estado\tNR\tRacha\tInicio\tFin" > headers_rachas;

./info_racha_por_estado.sh \
| ./info_racha_por_estado.R \
| ./sumariza_racha_por_estado.sh \
| awk '{if(NR == 1){ print "Estado\tNR\tRacha\tInicio\tFin"; print }else{ print }}'

# cat headers_rachas rachas.result
