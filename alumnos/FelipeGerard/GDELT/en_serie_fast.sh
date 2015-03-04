#! /bin/zsh

for gdelt_file in *.zip
do
    unzip -p $gdelt_file \
	| cut -f3,27,31 \
	| awk '{ $2 = substr($2,0,2); print $0 }' 
done \
| awk '
  {
    evento[$1,$2]++;
    goldstein_scale[$1,$2]+=$3
  } END { for (i in evento) print substr(i,0,4) "\t" substr(i,5,2) "\t" substr(i,8,2) "\t" evento[i] "\t" goldstein_scale[i]/evento[i]}' \
| sort -k1 -k2
