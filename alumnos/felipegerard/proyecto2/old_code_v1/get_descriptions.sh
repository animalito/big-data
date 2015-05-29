#! /bin/sh

head -8 data_urls \
| parallel -j8 --progress "echo {} \
  | ./get_descriptions.R \
  | sed -e 's/Date...Time/Date_Time/' \
  | tr '|' '\t' \
  > datos/{/.}.ufo_desc"
