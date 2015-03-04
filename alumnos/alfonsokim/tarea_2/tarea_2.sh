cat UFO-Nov-Dic-2014.tsv |cut -d$'\t' -f2 | grep -E "?[(]" | sort | wc -l

