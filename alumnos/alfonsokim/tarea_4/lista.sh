#!/bin/bash

curl -s http://data.gdeltproject.org/events/index.html | awk 'NR < 3 { next } match($0, /<A HREF="([.\-0-9A-Za-z]*)">/, grp){ print "http://data.gdeltproject.org/events/" grp[1] }'