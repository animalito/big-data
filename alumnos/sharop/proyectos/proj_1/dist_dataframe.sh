cat daily_urls.txt |  parallel --will-cite -N50 --slf instancias.azure './getDataFrame.r {}'
./ttfile.sh join_files.r
parallel --nonall --slf instancias.azure   ' cat ~/out/part_frame*  > totfram.tsv
