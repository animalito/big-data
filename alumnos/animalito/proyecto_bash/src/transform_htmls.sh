#!/bin/bash

# name="ndxe201502.html"
# bname=`echo $(basename $name .html)`
# nname=$bname.csv
# #Rscript transform_htmls.r $nname
# < ../ndxe201502.html | ./transform_htmls.r $name $nname


for name in `ls | grep -E '*.html$'`; do
    nname=`echo $(basename $name .html).csv`
    cat $name | ./transform_htmls.r $name $nname
done
