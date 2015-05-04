#!/usr/bin/env sh

parallel --will-cite --nonall --slf instancias.azure 'rm -R out.txt' 
