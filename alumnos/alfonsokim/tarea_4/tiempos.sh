#!/bin/bash

{ time ./serie.sh; } 2> serie.txt
{ time ./serie_sincut.sh; } 2> serie_sincut.txt
{ time ./paralelo.sh; } 2> paralelo.txt
{ time ./paralelo_sincut.sh; } 2> paralelo_sincut.txt

