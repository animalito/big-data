#! /bin/zsh
# En la version de docker/osx, la linea de sed es: | sed -Ee 's/^\"//' -Ee 's/\"$//' -Ee 's/\" \"/|/g' \
# Pero cambia un poco para el sed de AWS
#parallel --nonall --slf instancias_aws "mkdir ~/ufo_data";

sed -n 6,10p data_urls \
| sed "s/.*\///" \
| parallel --progress --basefile get_data.R --slf instancias_aws \
   "echo {} \
   | ./get_data.R \
   | awk ' {if(NR==1){print}} !/Date...Time/{print}' \
   | sed -e 's/^\"//' -e 's/\"$//' \
         -e 's/\" \"/|/g' \
         -e 's/Date...Time/Date|Time/' \
         -e 's/\([0-9]\+[^0-9]\+\)//' \
         -e 's/ /|/' \
         -e 's/^\([0-9]\/\)/0\1/' \
         -e 's/\([0-9]\{2\}\/\)\([0-9]\{2\}\/\)\([0-9]\{2\}\)/\2\1\3/' \
         -e 's/^\([0-9]\/\)/0\1/' \
   | tr '|' '\t' \
   > ~/ufo_data/{.}.ufo"
