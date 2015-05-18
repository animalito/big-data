#! /bin/sh
# Recibe la lista de URLs
# $1: ruta para guardar html (ufo_html)

parallel -j50 --progress "curl -s {} > $1/{/.}.ufo_html"
