#!/usr/bin/env python

import re
import sys

#n = int(sys.argv[1]) # Leemos un entero como argumento
texto = sys.stdin.readline()  # Leemos texto desde el stdin

n = 0
while texto != '' or n < 10:
    n = n + 1
    texto = sys.stdin.readline()  # Leemos texto desde el stdin
    if texto != '':
        dur = texto.split('\t')[4]
        limpio = ''
        for c in dur:
            if c.isdigit():
                limpio + c
            elif c == '-':
                limpio + '+'
        print dur

#print n
