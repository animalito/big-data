#! /bin/bash
# $1: ruta de datos psv con id (ufo_psv_id)
# $2: ruta de descripciones html (descriptions_html)
# $3: ruta de datos definitivos de ufo (ufo)

ls $1 \
| grep .ufo_psv_id \
| parallel --progress -j8 \
        "< $1/{} awk -F'|' 'NR > 1 {print \"$2/\" \$10 \"_\" \$9 \".desc_html\"}' \
	| while read d
            do
                cat \$d | pup 'tr:last-of-type td:last-of-type font' | grep -v -E \"</?font\" | tr '\n' '|' | sed -E 's/\||<br>/<\\n>/g'
            done \
        | awk 'BEGIN {print \"Long_Description\"}{print}' | paste -d '|' $1/{/.}.ufo_psv_id - > $3/{/.}.ufo"


