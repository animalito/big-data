#parallel --nonall --slf instancias hostname
parallel --nonall --slf instancias "sudo apt-get install -y parallel"

parallel --nonall --slf instancias "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9"
###################### OJO #################### 
##### Si se cambia la versión de ubuntu hay que cambiar esta línea.
#####################################################
parallel --nonall --slf instancias "sudo chmod ugo+rw /etc/apt/sources.list"
parallel --nonall --slf instancias "echo 'deb http://cran.r-project.org/bin/linux/ubuntu saucy/' >> '/etc/apt/sources.list'"
parallel --nonall --slf instancias "sudo apt-get update"
parallel --nonall --slf instancias  "echo 'y' | sudo apt-get install r-base r-base-dev"

parallel --nonall --slf instancias  "sudo apt-get install libxml2-dev"
parallel --nonall --slf instancias "sudo apt-get install -y libcurl4-openssl-dev"

###### problemas.lib

parallel --nonall --slf instancias "sudo chmod ugo+rw /usr/lib/R/library"


parallel --nonall --slf instancias "sudo add-apt-repository -y 'ppa:marutter/c2d4u'"
parallel --nonall --slf instancias "sudo apt-get update -qq"
parallel --nonall --slf instancias "echo 'y' | sudo apt-get install r-cran-rvest"


############# script en PARALLEL ################

#> parallel --nonall Rscript ufo.r --slf instancias "./ufo.r"

# observaciones:  ufo.r  es el script en r
# para correr este documento se usa: > sh master.sh


#otros comandos utilies con mi datos... son ejemplos:

# Conectarse a una maquina:
#> ssh -i aws2.pem ubuntu@52.11.90.170

# subir un archivo especifico (en este caso un txt)
#> scp -i aws2.pem hola.txt ubuntu@52.10.8.19:~/

# descargar un archivo espcifico.  de aws a una ubicacion local
#> scp -i aws2.pem ubuntu@52.11.86.145:~/hola.txt ~/documents/

# Para modificar un file o script dentro de tu maquina de AWS puedes utilizar vim
#> vi hola.txt


############## no hacer caso ####################
# parallel --nonall --slf instancias "echo 'y' | sudo apt-get install -y r-cran-xml r-cran-stringr r-cran-testthat"
#extra, si se instala paquete desde linea, sino en R en el rscript se agrega el lib y el cran. ejemplo: install.packages("rvest",lib="/usr/lib/R/library",repos="http://cran.rstudio.com/")
#parallel --nonall --slf instancias "wget -c http://cran.r-project.org/src/contrib/rvest_0.2.0.tar.gz"
#parallel --nonall --slf instancias "set R_LIBS="/usr/lib/R/library" & R CMD INSTALL rvest_0.2.0.tar.gz"

# parallel --nonall --slf instancias "wget -c http://cran.r-project.org/src/contrib/rvest_0.2.0.tar.gz"
# parallel --nonall --slf instancias "R CMD INSTALL rvest_0.2.0.tar.gz"

# parallel --nonall --slf instancias "wget -c http://cran.r-project.org/src/contrib/httr_0.6.1.tar.gz"
# parallel --nonall --slf instancias "R CMD INSTALL httr_0.6.1.tar.gz"
# parallel --nonall --slf instancias "wget -c http://cran.r-project.org/src/contrib/RCurl_1.95-4.5.tar.gz"
# parallel --nonall --slf instancias "R CMD INSTALL RCurl_1.95-4.5.tar.gz"
# parallel --nonall --slf instancias "wget -c http://cran.r-project.org/src/contrib/XML_3.98-1.1.tar.gz"

# parallel --nonall --slf instancias "wget -c http://cran.r-project.org/src/contrib/rvest_0.2.0.tar.gz"
# parallel --nonall --slf instancias "R CMD INSTALL rvest_0.2.0.tar.gz"