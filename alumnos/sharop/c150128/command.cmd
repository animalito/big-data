cat UFO-Dic-2014.tsv | cut -f3 | sort | uniq -d -c | sort -t $'	' -nrk 1| head -5 > most_5.tsv
