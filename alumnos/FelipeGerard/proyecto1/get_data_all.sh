#! /bin/zsh
# call 1: time sed 1,100p data_urls | ./get_data_all.sh # renglones 1 a 100
# call 2: time sed 1,100d data_urls | ./get_data_all.sh # renglones a partir del 101


sed 's/.*\///' \
| parallel -j8 --progress \
  "echo {} \
  | ./get_data.R \
  | awk ' {if(NR==1){print}} !/Date...Time/{print}' \
  | sed -Ee 's/^\"//' -Ee 's/\"$//' -Ee 's/\" \"/|/g' \
  | tr '|' '\t' > datos/{.}.txt"
