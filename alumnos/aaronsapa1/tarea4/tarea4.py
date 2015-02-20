#!/usr/bin/env python

import sys
import re

es_rango = r'([0-9]+)-([0-9]+) *(.*)'
solo_num = r'([0-9]+) *(.*)'

def convierte_a_sec(line):
    aux = 1
    match = re.match(es_rango, line)
    if match:
        time = (int(match.group(1)) + int(match.group(2))) / 2
        if (re.search("min",match.group(3))):
            aux = 60
        elif (re.search("ho",match.group(3))):
            aux = 3600
        return time * aux
    match = re.match(solo_num, line)
    if match:
        time = int(match.group(1))
        if (re.search("min",match.group(3))):
            aux = 60
        elif (re.search("ho",match.group(3))):
            aux = 3600
        return time * aux
    raise Exception(' ***** ')

def main():
    line = sys.stdin.readline()

    suma = 0
    total = 0
    sumasq = 0
    auxmin = 999999
    auxmax = 0
    while line:
        total += 1
        line = line.replace('~', '').replace('+', '').strip()
        try:
            seconds = convierte_a_sec(line)
            suma += seconds
            sumasq += seconds * seconds
            if seconds < auxmin: 
                auxmin = seconds
            if seconds > auxmax: 
                auxmax = seconds
        except Exception, e:
            total -= 1
        line = sys.stdin.readline()
    print 'mean:%i, min:%i, max:%.2f, stdev:%.2f' % ((suma / total), auxmin, auxmax, ((sumasq / total) - (suma / total)**2)**.5) 

if __name__ == '__main__':

    main()