cat UFO-Nov-Dic-2014-limpio.tsv | cut -f5 | grep "[0-9].*" | \
grep -E "^[0-9]+ [a-zA-Z]+" | \
grep -E ".*[minutes|minute|hours|hour|seconds|second].*" \
 > UFO-Nov-Dic-2014-numeros_r.tsv

sed 's/ /|/' UFO-Nov-Dic-2014-numeros_r.tsv  > UFO-Nov-Dic-2014-numeros_r_2.tsv
#echo "FINAL_ARCHIVO" >> UFO-Nov-Dic-2014-numeros_r.tsv 
cat UFO-Nov-Dic-2014-numeros_r_2.tsv | ./estadisticas.r

