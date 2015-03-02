#!/bin/bash

for name in `ls | grep -E '*.html$'`; do
    nname=`echo $(basename $name .html).csv`
    cat $name | ./transform_htmls.r $name $nname
done

# oneliner
ls | grep -E "*.html$" | xargs -0 -d'\n' -I {} ./transform_htmls.r {} $(basename {}).csv
