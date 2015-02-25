#!/bin/bash

DELT_LINKS_URL="http://data.gdeltproject.org/events/index.html"
CURL_ARGS="-s"

curl $CURL_ARGS $DELT_LINKS_URL | grep -oP '(?<=HREF=\")\d.*(?=\")' | awk '{print "http://data.gdeltproject.org/events/"$1}' > filelist.txt
