#! /bin/sh

parallel -j50 --progress "curl -s {} > ../html/{/.}.ufo_html"
