#!/bin/bash

## Este script invoca al conteo agregado, se pasa como
## parametro una unidad de tiempo sobre la cual se
## quieren agrupar los avistamientos

cat data.csv | python counter.py $1 | head -1