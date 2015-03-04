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
              d = substr(\$2,1,2); \
              m = substr(\$2,4,2); \
              y = substr(\$2,7,2); \
              if(match(y,/[0-1][0-9]/) > 0){ \
                print \$1, \"20\" y \"-\" m \"-\" d; \
              }else{ \
                print \$1, \"19\" y \"-\" m \"-\" d; \
              } \
            } \
          '; \
      done" \
| grep -E '[A-Z]{2}.[0-9]{4}-[0-9]{2}-[0-9]{2}' \
| sort -k1 -k2

          #| sed 's/\(^[0-9][0-9]\/\)\([0-9]\+\/\)\([0-9][0-9]\)/\3/' \
          #| grep '^[0-9][0-9] [A-Z][A-Z]$' \
          #| sort -t ' ' -k 2 -k 1 \
          #| uniq -c \
          #| sed -e 's/^ \+//
#| awk -F' ' '{ count[$2,$3] += $1 } END { for(i in count) print substr(i,1,2), substr(i,4,2), count[i] }' \
#| awk -F' ' '{if(match($1,/[0-1][0-9]/) > 0){$1 = 20$1}else{$1 = 19$1}; print}' \
#| sort -k 1n,1 -k 3nr,3 \
#| awk -F' ' '{if(NR==1 || yr!=$1){yr=$1; n=1}else{if(n<6){print; n++}}}'

