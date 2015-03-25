#! /bin/zsh

< urls_GDELT.tsv | cut -d' ' -f2 \
  | sed 's/"//g' \
  | grep gdeltproject \
  | sed -Ee 's/(events\/)(.+\.zip)/\1\2 > \2/' -Ee 's/^/curl /'
  | /bin/zsh
