#!/bin/bash


< UFO-Nov-Dic-2014.tsv cut  -f5 | sort | grep -E "[0-9]+" | python tarea4.py