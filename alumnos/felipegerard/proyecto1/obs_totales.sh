#! /bin/zsh

parallel --nonall --progress --slf instancias_aws \
    "for file in \$(find ufo_data/*); do wc -l \$file; done \
    | awk -F' ' '{ suma += \$1 } END { print suma }'" \
| awk '{ suma += $1 } END { print suma }'
