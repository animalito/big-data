#! /bin/bash
# In:
# $1: Carpeta de origen con archivos GDELT
# $2: Carpeta destino con archivos GDELT que sólo incluyen lo que tiene que ver con México
# $3: Primer archivo (1 = empieza con el primero del find)
# $4: Ultimo archivo

a=$3
b=$4
if [ $a = ]
then
    a=1
fi
if [ $b = ]
then
    b=`find $1 | wc -l | xargs`
fi
echo "Fuente: $1"
echo "Destino: $2"
echo "a = $a"
echo "b = $b"

find $1 \
| grep .zip \
| sed -n $a,"$b"p \
| parallel -j8 --eta "unzip -p {} | grep Mexico | grep -v 'New Mexico' | tr '\t' '|' | awk -F'|' 'BEGIN {OFS=\"|\"}{if(NF == 57){print \$0,\"\"}else{print \$0}}' > $2/{/.}.mex"

# Nota: El awk agrega un campo al final de los registros antiguos, que en el formato nuevo corresponde a las urls del suceso. 
















