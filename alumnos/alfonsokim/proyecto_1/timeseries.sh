#!/bin/bash

## Genera la serie de tiempo para el estado dado de argumento,
## si no se pasa ningun argumento se procesan todos los datos (todo el pais)

cat data.csv | python timeseries.py $1
