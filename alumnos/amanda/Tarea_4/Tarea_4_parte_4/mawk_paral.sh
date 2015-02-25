#!/bin/bash


# Paralelo mawk

find . -type f -name '*.zip' -print0 | \
parallel -0 -j100% \
"unzip -p {} | \
cut -f3,27,31 | \
mawk '{\$2 = substr(\$2,1,3); print \$0 }' | \
mawk '{
  evento[\$1,\$2]++;
  goldstein_scale[\$1,\$2]+=\$3
} END { for (i in evento) print i FS evento[i] FS goldstein_scale[i]}'" | \
mawk  '{
  evento[$1]+=$2;
  goldstein_scale[$1]+=$3
} END { for (i in evento) print substr(i, 1, 5) "\t" substr(i,6,8) "\t" substr(i,9,11) "\t" evento[i] "\t" goldstein_scale[i]/evento[i]}' | sort -k1 -k2