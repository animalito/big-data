#! /bin/bash

find ../datos/ufo_psv_id \
| grep .ufo_psv_id \
| parallel -j8 --progress \
"< {} awk -F'|' '{print \"curl -s\", \$8, \">\", \"../datos/descriptions_html/\" \$10 \"_\" \$9 \".desc_html\" }' | grep ndxe" \
| parallel -j50 --progress "\$({})"

