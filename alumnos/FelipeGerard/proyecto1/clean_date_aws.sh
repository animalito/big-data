#! /bin/zsh

parallel --nonall --progress --slf instancias_aws \
"for file in \$(ls ufo_data); \
do \
cat ufo_data/\$file | sed -e 's/\t/|/g' \
                  -e 's/[_ ]/|/' \
                  -e 's/^\([0-9]\/\)/0\1/' \
                  -e 's/\([0-9]\{2\}\/\)\([0-9]\{2\}\/\)\([0-9]\{2\}\)/\2\1\3/' \
  | tr '|' '\t' > ufo_data/\$file; \
done"
