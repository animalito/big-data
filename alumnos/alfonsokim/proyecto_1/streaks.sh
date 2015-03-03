#!/bin/bash

## Llama al script de python que detecta las rachas
## Recibe como argumento un estado, si no se pasa
## nada de argumento lo calcula para todo el pais

cat data.csv | python state_streak.py $1 | head -1