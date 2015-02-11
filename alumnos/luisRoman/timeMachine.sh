#! /bin/bash

curl https://www.gutenberg.org/cache/epub/35/pg35.txt | tr "[:upper:]" "[:lower:]" | grep -oE "\w+" | sort | uniq -c | sort 
-nr | head -n 10

# curl obtiene el texto de la ruta especificada.
# tr: transformamos mayúsculas en minúsculas.
# grep: obtenemos sólo las palabras (-oE "\w+").
# sort: las acomodamos de tal forma que todas las palabras iguales sean consecutivas.
# uniq: contamos palabras únicas (-c).
# sort: los acomodamos en orden decreciente con respecto a la cuenta (-nr).
# head: desplegamos las primeras 10 (-n 10).
