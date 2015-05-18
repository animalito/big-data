#! /bin/bash
# $1: ruta a datos html (ufo_html)
# $2: ruta a datos psv (ufo_psv)

find $1 | parallel -j8 --progress "echo {} | ./process_html.R > $2/{/.}.ufo_psv"


