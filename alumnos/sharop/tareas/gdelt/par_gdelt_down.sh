#!/bin/bash

cat filelist.txt | parallel --eta --slf instancias 'wget {}'
parallel --nonall -slf instancias ''
parallel --nonall --slf instancias 'mkdir gdelt_files && mv *.zip gdelt_files'
