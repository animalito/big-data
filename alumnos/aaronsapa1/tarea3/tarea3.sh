#!/bin/bash
< UFO-Nov-Dic-2014.tsv cut  -f5 | sort | grep -E "[0-9]+" > Duration.txt
sed  -i  's/[0-9][-|\/]//' Duration.txt
< Duration.txt  grep -E "sec" | grep -oE "[0-9]+" > seconds.txt
< Duration.txt  grep -E "m" | grep -oE "[0-9]+"> minutes.txt
< Duration.txt  grep -E "ho" | grep -oE "[0-9]+"> hours.txt
awk '{$1=$1*60; print}' minutes.txt >> seconds.txt 
awk '{$1=$1*3600; print}' hours.txt >> seconds.txt 
sed  -i  's/[0-9][-|\/]//' Duration.txt 
sed  -i  's/[0-9][-|\/]//' minutes.txt 
sed  -i  's/[0-9][-|\/]//' hours.txt 
awk '{FS="|"}{if(min==""){min=max=$1}; if($1>max) {max=$1};if($1<min) {min=$1}; count+=1; sum+=$1; sumsq+=$1*$1} END {print "mean = " sum/NR,"min = " min, "max = " max, "stdev = " sqrt(sumsq/NR - (sum/NR)*(sum/NR))}' seconds.txt