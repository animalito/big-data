#! /bin/zsh

sed 's/"//g' \
| awk -F',' '
  {
    if(NR == 1){
      inicio = $3
      fin = inicio
    }
    if($4 == 1){
      racha++
      fin = $3
    }else{
      rachas[$2,$1-1] = racha
      inicios[$2,$1-1] = inicio
      fines[$2,$1-1] = fin
      inicio = $3
      fin = inicio
      racha = 1
    }
  }
  END {
    OFS = "\t"
    for(i in rachas){
      print substr(i,1,2), substr(i,3), rachas[i], inicios[i], fines[i]
    }
  }
' \
| sort -k 1,1 -k 3nr,3 -k 4r,4 \
| awk 'BEGIN { state="" } {if(NR == 1 || state != $1){ print; state = $1 } }'
