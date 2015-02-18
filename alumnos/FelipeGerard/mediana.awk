## Obtenido de http://stackoverflow.com/questions/6166375/median-of-column-with-awk

{
    count[NR] = $1;
}
END {
    if (NR % 2) {
        print "mediana = " count[(NR + 1) / 2];
    } else {
        print "mediana = " (count[(NR / 2)] + count[(NR / 2) + 1]) / 2.0;
    }
}
