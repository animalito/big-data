#! /bin/zsh

find . -type f -name '*.zip' -print0 | \
parallel -0 -j7 \
"unzip -p {} | \
cut -f3,27,31 | \
awk '{\$2 = substr(\$2,0,2); print \$0 }' | \
awk '{
  evento[\$1,\$2]++;
  goldstein_scale[\$1,\$2]+=\$3
} END { for (i in evento) print i FS evento[i] FS goldstein_scale[i]}'" | \
awk  '{
  evento[$1]+=$2;
  goldstein_scale[$1]+=$3
} END { for (i in evento) print substr(i, 0, 4) "\t" substr(i,5,2) "\t" substr(i,8,2) "\t" evento[i] "\t" goldstein_scale[i]/evento[i]}' | sort -k1 -k2
