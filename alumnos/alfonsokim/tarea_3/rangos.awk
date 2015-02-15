
## Este script busca los tiempos en formato hh:mm:ss y los convierte a segundos
## y busca los tiempos que estan dados en rangos (1-2, 5-10, etc)
## En caso de estar en rango la salida es el promedio del rango (5-10 = 7.5)

m = 0; 
match($0, /([0-9][0-9]?):([0-9]+):([0-9]+)/, grp){
    m = 1;
    print ">" ((grp[1] * 60 * 60) + (grp[2] * 60) + grp[3]) " seconds"
}
match($0, /([0-9]+):([0-9]+)/, grp){
    m = 1;
    print ">" ((grp[1] * 60) + grp[2]) " seconds"
}
match($0, /([0-9]+)-([0-9]+)(.*)/, grp){ 
    m = 1; 
    print ((grp[1] + grp[2]) / 2) grp[3] 
};
{
    if(m == 0) {  ## Si la linea no esta en formato rango 
        print $0  ## Se imprime para la siguiente etapa
    }
} 
