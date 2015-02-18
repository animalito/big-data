cat UFO-NOV-Dic-2014-limpio.tsv | cut -d$'\t' -f4 | sort | grep -v "Sphere" | wc -l
