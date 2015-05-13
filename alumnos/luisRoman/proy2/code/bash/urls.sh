#!/usr/bin/bash

curl http://data.gdeltproject.org/events/index.html | grep -oE '".*"' | sed 's%"%data.gdeltproject.org/events/%' | sed 's/"//' | grep -E 'events/[0-9]+' > urls.txt 

for i in `cat urls.txt`
do
wget -P ./files $i
done

