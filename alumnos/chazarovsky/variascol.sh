#!/bin/bash
echo "de qué archivo quieres estadisticos?"
read archivo
echo "de qué columna quieres estadisticos?"
   read var
awk -v x=$var '{FS=","}{sum+=$x; sumsq+=$x*$x; if(min==""){min=max=$x}; if($x>max) {max=$x};if($x<min) {min=$x}; total+=$x; count+=1} END {print "mean = " total/count,"min = " min, "max = " max, "stdev = " sqrt(sumsq/NR - (sum/NR)**2);}' $archivo