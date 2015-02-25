#!/usr/bin/env python

import re 
import sys 
import math

datos = []
datos_cua = []
media = 0
maximo = 0 
minimo = 0 
median = 0
varianza = 0 
desviacion = 0

while True:
    linea = int(sys.stdin.readline())
    datos.append(linea)  
    datos_cua.append(linea*linea)
    if not linea:
        break

n = len(datos)
media = int(sum(datos) / n)
maximo = max(datos)
minimo = min(datos)
varianza = int((sum(datos_cua) / n) - (media*media))
desviacion = int(math.sqrt(varianza))

# Calculamos la mediana
datos_ord = sorted(datos)
#datos_ord = datos.sort()                                                                             
mitad = n / 2
if n % 2 == 0:
    mediana = (datos_ord[mitad + 1] + datos_ord[mitad + 2]) / 2
else:
    mediana = datos_ord[mitad + 1]

print "Media = ", media
print "Maximo = ", maximo
print "Minimo = ", minimo
print "Mediana = ", mediana
print "Desviacion estandar = ", desviacion
print "Varianza = ", varianza