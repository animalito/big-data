function mediana(c,v,j) {
    #asort(v,j); ## Ordena y asigna enteros a la posición
    if (c % 2) {
        return j[(c+1)/2];
    } else {
        return (j[c/2+1]+j[c/2])/2.0;
    }
}
{
    count++;
    values[count]=$1;
} END {
    print  "mediana = " mediana(count,values);
}
