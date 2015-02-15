
## Este bloque busca los tiempos que estan dados en rangos (1-2, 5-10, etc)
## La salida es el promedio del rango (5-10 = 7.5)

m = 0; 
match($0, /(([0-9]+))-(([0-9]+))(.*)/, grp){ 
    m = 1; 
    print ((grp[1] + grp[3]) / 2) grp[5] 
};
{
    if(m == 0) {  ## Si la linea no esta en rango 
        print $0  ## Se imprime para la siguiente etapa
    }
} 
