#!bin/bash

# Nice to know!

# Comillas dobles> se sustiuyen los comandos adentro y se ejecutan. 
# Comillas simples > se interpreta como cadena de texto

################################
# Ejercicio
# Transforma el archivo de `data` de tabuladores a `|`, cambia el nombre con terminación `.psv`.
# Pretty print
cat UFO-Dic-2014.tsv | tr -s '\t' '|'

# Lo guardamos bonito
cat UFO-Dic-2014.tsv | tr -s '\t' '|' > UFO-Dic-2014.psv
# Otra opcion para guardar
< UFO-Dic-2014.tsv tr -s '\t' '|' > UFO-Dic-2014.psv

# Checo que esta bien ~mismo numero de filas
wc -l UFO*
################################
# Mas ejercicios de comanditos
# Pegamos archivos
cat ../../lecture_2/data/UFO-Nov-2014.tsv UFO-Dic-2014.tsv > UFO-Nov-Dic-2014.tsv

# Dividimos archivos
split -l 500 UFO-Nov-Dic-2014.tsv 

# Ordeno 
sort -t '|' -k 2  UFO-Dic-2014.psv | head

################################
# Ejercicio: ¿Cuál es el top 5 de estados por avistamiento?
cat UFO-Dic-2014.tsv \
    | cut -d$'\t' -f3 \
    | sort -t $'\t' -k 2 -k 1 \
    | uniq -c | sort -t $'\t' -k 1 | head
################################
