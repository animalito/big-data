#Descargar los avistamientos
parallel --nonall Rscript scrapping.r --slf instance "./scrapping.r"

#Config aws
parallel --nonall --slf instancias "sudo apt-get install -y parallel"
parallel --nonall --slf instancias "sudo apt-get update"
parallel --nonall --slf instance "sudo apt-get update; sudo apt-get install -y r-base-core"
parallel --nonall --slf instance "sudo apt-get install -y libcurl4-gnutls-dev"
parallel --nonall --slf instance "sudo apt-get install -y r-cran-xml"

#Dentro de la maquina virtual
sudo R 
install.packages('rvest', repos="http://cran.us.r-project.org", dependencies=TRUE)


## para la grafica y asi
< ufo.txt cut -d$'\t' -f2,4   \
	| grep -E '"([A-Z]+)"' \
	| sed -r 's/([0-9]+):([0-5]?[0-9]):([0-5]?[0-9])//' \
    | sed -r 's/([01]?[0-9]|2[0-3]):[0-5][0-9]//' \
    | sed -r 's/^(19|20)//' \
    | tr -s  '\t' ',' \
    | sed -r 's/ //' \
    | sed 1d \
    | python porEstado.py "NY"

#¿Cuántas observaciones totales? ------> 96111
< ufo.txt wc -l

#¿Cuál es el top 5 de estados?
#11124 "CA"
#5057 "FL"
#4968 "WA"
#4326 "TX"
#3808 "NY"
#3181 "AZ"
< ufo.txt \
      | cut -d$'\t' -f4 \
      | grep -E '"([A-Z]+)"' \
      | sort \
      | uniq -c \
      | sort -rn\
      | head -n 5

#¿Cuál es el top 5 de estados por año?
#851 "14 "	"CA"
#627 "14 "	"FL"
#373 "14 "	"PA"
#364 "14 "	"WA"
#315 "14 "	"NY"
< ufo.txt \
      | cut -d$'\t' -f2,4 \
      | sed -r 's/[0-9]+\/[0-9]+\///' \
      | grep -E '"([A-Z]+)"' \
      | sed -r 's/([0-9]+):([0-5]?[0-9]):([0-5]?[0-9])//' \
      | sed -r 's/([01]?[0-9]|2[0-3]):[0-5][0-9]//' \
      | sort -t $'\t' -k 1 -k 2 \
      | uniq -c \
      | sort -nr \
      | grep -E '14' \
      | head -n 5

#El otro, donde haces como group by de a;o y estado que no entendi

< ufo.txt \
      | cut -d$'\t' -f2,4 \
      | sed -r 's/[0-9]+\/[0-9]+\///' \
      | grep -E '"([A-Z]+)"' \
      | sed -r 's/([0-9]+):([0-5]?[0-9]):([0-5]?[0-9])//' \
      | sed -r 's/([01]?[0-9]|2[0-3]):[0-5][0-9]//' \
      | sort -t $'\t' -k 1 -k 2 \
      | uniq -c \
      | sort -nr \
      | head -n 10

#¿Cuál es la racha más larga en días de avistamientos en un estado?
find . -type f -name 'ufo.txt' parallel sed 1d \
	| cut -f1,3 \
	| grep --color=auto -E "[0-9]+[0-9]?/[0-9]+[0-9]?/[0-9]+[0-9]+" \
	| sed -E 's/( [0-9]+[0-9]+:[0-9]+[0-9]+)//' \
	| sed -E 's/[0-9]+[0-9]?\///' \
	| sed -E 's/\/[0-9]+[0-9]?//' \
	| grep "MI" \
	| uniq > prueba.csv

¿Cuál es el mes con más avistamientos? ¿El día de la semana?
#mes
 11540 "7"
  10406 "8"
  10061 "6"
   9212 "9"
   9024 "10"
< ufo.txt \
      | cut -d$'\t' -f2 \
      | sed -r 's/\/[0-9]+\/[0-9]+//' \
      | sed -r 's/([0-9]+):([0-5]?[0-9]):([0-5]?[0-9])//' \
      | sed -r 's/([01]?[0-9]|2[0-3]):[0-5][0-9]//' \
      | sed -r 's/ //' \
      | sort \
      | uniq -c \
      | sort -nr \
      | head -n 5


#dia
    < ufo.txt \
      | cut -d$'\t' -f2 \
      | sed -r 's/([0-9]+):([0-5]?[0-9]):([0-5]?[0-9])//' \
      | sed -r 's/([01]?[0-9]|2[0-3]):[0-5][0-9]//' \
      | sed -r 's/ //' \
      | sort \
      | uniq -c \
      | sort -nr \
      | head -n 5