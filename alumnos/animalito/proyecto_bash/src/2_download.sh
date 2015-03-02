#!/bin/bash

echo

SOURCE="${BASH_SOURCE[0]}"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo Ejecutando $SOURCE
echo Carpeta de ejecución $DIR

cat $DIR/../data/urls.txt | parallel --eta --slf $DIR/../data/instancias.txt 'wget {}'
