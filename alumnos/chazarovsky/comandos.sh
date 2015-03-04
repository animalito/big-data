parallel --nonall --slf instancias.txt "sudo apt-get update; sudo apt-get install -y r-base-core" #instala R
parallel --nonall --slf instancias.txt "sudo apt-get install -y parallel"    #instala parallel
parallel --nonall Rscript ufoscrap.R --slf instancias.txt "./ufoscrap.R" # corre el archivo de scrap en todas las instancias