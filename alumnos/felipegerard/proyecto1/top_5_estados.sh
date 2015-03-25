#! /bin/zsh

parallel --nonall --progress --slf instancias_aws \
    "for file in \$(find ufo_data/*); do awk -F' ' '{ print \$4 }' \$file | sort | uniq -c; done" \
| sed -e 's/ \+//' -e 's/[^ 0-9A-Z]//g' \
| egrep ' [A-Z][A-Z]$' \
| sort -k 2  \
| awk -F' ' '{ n[$2] += $1 } END { for(state in n) print state, n[state] }' \
| awk -F' ' '{ if($2 > 50) print }' \
| sort -nrk 2
# | sed -n 1,5p # Esto es para que de el top 5 en lugar del ranking completo
