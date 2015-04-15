#!/bin/bash
#cada vez que prendas as maquinillas tienes que modificar el archivo de las intancias 

# para bajar los titulos 
DELT_LINKS_URL="http://www.nuforc.org/webreports/ndxevent.html"
CURL_ARGS="-s"
curl $CURL_ARGS $DELT_LINKS_URL | grep -oP '(?<=HREF=\")\d.*(?=\")' | awk '{print "http://www.nuforc.org/webreports/ndxevent.html/"$1}' > filelist_ufo.txt


# Para  leer los titulos y distribuirlos 

cat filelist_ufo.txt | parallel --eta --slf instancias.txt 'wget {}'
parallel --nonall --slf instancias.txt ''
parallel --nonall --slf instancias.txt 'mkdir ufo_files && mv *.zip ufo_files'