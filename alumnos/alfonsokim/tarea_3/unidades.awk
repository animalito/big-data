
## Este script unifica las unidades a segundos
## Las lineas que no coiniciden con los patrones
## se escriben a un archivo "raros.txt" para su
## futuro anlisis manual

m = 0;
match($0, /([0-9]+\.?[0-9]?[ ]*)milli(.*)$/, grp){ ## Hay un caso con milisegundos
    m = 1;
    print grp[1] / 1000
}
match($0, /([0-9]+\.?[0-9]?[ ]*)sec(.*)$/, grp){
    m = 1;
    print grp[1]
}
match($0, /([0-9]+\.?[0-9]?[ ]*)min(.*)$/, grp){
    m = 1;
    print grp[1] * 60
}
match($0, /([0-9]+\.?[0-9]?[ ]*)hour(.*)$/, grp){
    m = 1;
    print grp[1] * 60 * 60
}
{
    if (m == 0){
        print $0 >> "raros.txt"
    }
}