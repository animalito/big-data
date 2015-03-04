#!/bin/bash


# Serie mawk

for gdelt_file in *.zip
do \
unzip -p $gdelt_file | \
cut -f3,27,31 | \
mawk '{$2 = substr($2,1,3); print $0 }' | \
mawk '{
  evento[$1,$2]++;
  goldstein_scale[$1,$2]+=$3
} END { for (i in evento) print i "\t" evento[i]"\t"goldstein_scale[i]}'
done | \
mawk  '{
  evento[$1]+=$2;
  goldstein_scale[$1]+=$3
} END {
  for (i in evento)
    print substr(i, 1, 5) "\t" substr(i,6,8) "\t" substr(i,9,11) "\t" evento[i] "\t" goldstein_scale[i]/evento[i]
}' | \
sort -k1 -k2
