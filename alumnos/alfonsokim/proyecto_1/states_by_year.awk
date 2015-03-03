
## Las fechas estan en formato mes/dia/anio =S
##

m = 0; 
match($0, /([0-9][0-9]?)\/([0-9][0-9]?)\/([0-9][0-9])( *)([0-9:]*)\|([A-Z]{2})/, grp){
    m = 1;
    print grp[3] "|" grp[6]
};
{
    if(m == 0) {  ## Si la linea no esta en formato rango 
        # print "NO ES FECHA =( ", $0
    }
} 
