#!/bin/bash

## Este script obtiene el numero total de avistamientos descargados

wc -l data.csv | grep -o '[0-9]*'

