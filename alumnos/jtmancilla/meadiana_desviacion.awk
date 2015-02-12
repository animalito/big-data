sort -n | awk '{for(i=1;i<=NF;i++) {sum[i] += $i; sumsq[i] += ($i)^2}}
          END {for (i=1;i<=NF;i++) {
          print "%f %f \n", x=int((i+1)/2); if (x < (i+1)/2) print (x-1+x)/2; else print x-1, sqrt(sumsq[i]/NR - (sum[i]/NR)**2)}
         }' data2.txt

