#! /bin/zsh

sed '1d;s/"//g' \
| awk -F',' '
  {
    if(NR == 1){
      inicio = $2
      fin = inicio
    }
    if($3 == 1){
      racha++
      fin = $2
    }else{
      rachas[$1-1] = racha
      inicios[$1-1] = inicio
      fines[$1-1] = fin
      inicio = $2
      fin = inicio
      racha = 1
    }
  }
  END {
    OFS = "\t"
    for(i in rachas){
      print i, rachas[i], inicios[i], fines[i]
    }
  }
' \
| sort -k 2nr,2 -k 3r,3 \
| awk 'BEGIN { OFS="\t" } {if(NR == 1){ print "NR", "Racha", "Inicio", "Fin"; print }else{ print }}'
