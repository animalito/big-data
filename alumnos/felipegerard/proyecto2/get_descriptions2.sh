#! /bin/sh

parallel -j100 --progress "echo {} \
  | ./get_descriptions.R \
  | sed -e 's/Date...Time/Date_Time/' \
  > datos/{/.}.ufo_desc"
