#! /bin/bash
# $1: ruta a datos con id (ufo_psv_id)
# $2: ruta para guardar los datos (descriptions_html)
find $1 \
| grep .ufo_psv_id \
| parallel -j8 --progress \
"< {} awk -F'|' '{print \"curl -s\", \$8, \">\", \"$1/\" \$10 \"_\" \$9 \".desc_html\" }' | grep ndxe" \
| parallel -j50 --progress "\$({})"

