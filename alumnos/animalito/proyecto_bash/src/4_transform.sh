#!/bin/bash

echo

SOURCE="${BASH_SOURCE[0]}"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo Ejecutando $SOURCE
echo Carpeta de ejecución $DIR

echo Pasamos de html a csv
#parallel --basefile transform_html.r --slf $DIR/../data/instancias.txt "ls ~/ | grep -E '*.html$' | xargs -0 -d'\n' -I {} ./transform_htmls.r {} $(basename {}).csv"

#parallel  --nonall --basefile transform_htmls.r --slf ../data/instancias.txt "find . *.html -exec ./transform_htmls.r \{\} \{\}.csv \;"

parallel  --nonall --basefile transform_htmls.r --slf ../data/instancias.txt "find . *.html -exec ./transform_htmls.r \{\} \{.\}.csv \;"
