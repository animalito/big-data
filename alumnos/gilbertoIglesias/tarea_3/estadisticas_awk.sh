cat UFO-Nov-Dic-2014-limpio.tsv | cut -f5 | grep "[0-9].*" | \
grep -E "^[0-9]+ [a-zA-Z]+" | \
grep -E ".*[minutes|minute|hours|hour|seconds|second].*" \
 > UFO-Nov-Dic-2014-numeros_awk_1.tsv

sed 's/ /|/' UFO-Nov-Dic-2014-numeros_awk_1.tsv > UFO-Nov-Dic-2014-numeros_awk_2.tsv

awk '
{FS="|"}
{
  factor=0;
  if($2=="minutes" || $2=="minute"){factor=60};
  if($2=="hours" || $2=="hour" ){factor=3600}; 
  if($2=="seconds" || $2=="second"){factor=1};
  num_final = $1 * factor;
  sum_2 += num_final * num_final; 
  sum+= num_final;
  count+=1;
} 
END {
  print "mean = " sum/count; 
  print "desv std = " sqrt(sum_2/NR - (sum/NR)**2);
}
' UFO-Nov-Dic-2014-numeros_awk_2.tsv 

