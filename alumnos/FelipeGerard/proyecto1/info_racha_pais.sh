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
                print \"20\" y \"-\" m \"-\" d; \
              }else{ \
                print \"19\" y \"-\" m \"-\" d; \
              } \
            } \
          '; \
      done" \
| grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2}' \
| sort \
| uniq
