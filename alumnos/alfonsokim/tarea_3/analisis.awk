
## En este script se realiza el analisis de los tiempos
##

BEGIN { min = 100000; max = 0; sum = 0; sumsq = 0 }
{
    if($1 < min){
        min = $1
    }
    if($1 > max){
        max = $1
    }
    sum += $1;
    sumsq += $1*$1
}
END { print "MIN:" min ", MAX:" max ", AVG:" sum/NR ", STDDEV:" sqrt(sumsq/NR - (sum/NR)**2) }