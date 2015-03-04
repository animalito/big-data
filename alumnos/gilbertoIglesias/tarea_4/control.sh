#!/bin/bash
php adquirir_urls.php  > archivos.txt
cat archivos.txt | grep -E ".*zip.*" | \
(cd /home/gilberto/ITAM/metodos_gran_escala/data/gdelt/; xargs -I % curl -O %)

