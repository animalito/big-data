#! /bin/bash

ls ../datos/ufo_psv_id \
| grep .ufo_psv_id \
| parallel --progress -j8 \
        "< ../datos/ufo_psv_id/{} awk -F'|' 'NR > 1 {print \"../datos/descriptions_html/\" \$10 \"_\" \$9 \".desc_html\"}' \
	| while read d
            do
                cat \$d | pup 'tr:last-of-type td:last-of-type font' | grep -v -E \"</?font\" | tr '\n' '|' | sed -E 's/\||<br>/<\\n>/g'
            done \
        | awk 'BEGIN {print \"Long_Description\"}{print}' | paste -d '|' ../datos/ufo_psv_id/{/.}.ufo_psv_id - > datos/ufo/{/.}.ufo"


