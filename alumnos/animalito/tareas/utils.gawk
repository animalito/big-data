function mediana(c,v,j) {
    asort(v,j); ## Ordena y asigna enteros a la posición: ordena al vector original guardado en v. Y lo copia ordenado a j
    if (c % 2) {
        return j[(c+1)/2];
    } else {
        return (j[c/2+1]+j[c/2])/2.0;
    }
}
function sd(c,s,sc){ #count=numero renglones, s=suma columna, sc=suma cuadrados
    return sqrt(sc/c - (s/c)**2);
}
{
    count++;
    values[count]=$1;
    sum+=$1;
    sumsq+=$1*$1;
} END {
    print  "mediana = " mediana(count,values);
    print  "desv est = " sd(count, sum, sumsq);
}
