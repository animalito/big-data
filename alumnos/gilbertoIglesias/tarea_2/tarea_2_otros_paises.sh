cat UFO-NOV-Dic-2014-limpio.tsv |cut -d$'\t' -f2 | grep -E "?[(]" | sort | wc -l
