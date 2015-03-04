#!/bin/bash

for gdelt_file in *.zip
do
unzip -p $gdelt_file | \
awk 'BEGIN { FS = "\t" } ; { print $3 "\t" $27 "\t" $31 }' | \
## cut -f3,27,31 | \
awk '{$2 = substr($2,0,2); print $0 }' | \
awk '{
  evento[$1,$2]++;
  goldstein_scale[$1,$2]+=$3
} END { for (i in evento) print i "\t" evento[i]"\t"goldstein_scale[i]}'
done | \
awk  '{
  evento[$1]+=$2;
  goldstein_scale[$1]+=$3
} END {
  for (i in evento)
    print substr(i, 0, 4) "\t" substr(i,5,2) "\t" substr(i,8,2) "\t" evento[i] "\t" goldstein_scale[i]/evento[i]
}' | \
sort -k1 -k2
