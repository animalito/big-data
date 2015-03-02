#! /bin/zsh

parallel --nonall --progress --slf instancias_aws \
    "for file in \$(find ufo_data/*); \
      do \
        awk -F'\t' '{ if(NR != 1) print \$4, \$1}' \$file \
        | grep '^[A-Z][A-Z] ' \
        | sed -e 's/ \([1-9]\)\// 0\1\//' \
              -e 's/\/\([0-9]\)\//\/0\1\//' \
        | awk -F' ' '\
            BEGIN {\
              OFS = \"\t\" \
            } \
            { \
              print substr(\$2,4,2); \
            } \
          '; \
      done" \
| grep -E '(0[1-9])|(1[0-2])' \
| sort \
| uniq -c \
| awk '{ print $2, $1 }' \
> temp001.temp;

echo "ene,feb,mar,abr,may,jun,jul,ago,sep,oct,nov,dic" | tr ',' '\n' > temp002.temp;

paste temp002.temp temp001.temp | tr ' ' '\t' | sort -k3nr \
| awk -F'\t' 'BEGIN { OFS = "\t" } { if(NR == 1){ print "Ranking", "Mes", "MesNum", "Avistamientos"; print NR, $0}else{ print NR, $0}}'


