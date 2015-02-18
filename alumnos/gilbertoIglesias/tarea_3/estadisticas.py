#!/usr/bin/env python

#if __name__ == "__main__":
#  import sys
#  x = int(sys.argv[1])

import re
import sys
import math

#n = int(sys.argv[1]) # Leemos un entero como argumento (opcional)
var = True
elem_final = []
sum = 0
count = 0
while var == True:
  linea = sys.stdin.readline()
  if linea != "": 
    arr = linea.split( );
    #print arr
    if len(arr) == 2:
      factor=0;
      if(arr[1]=="minutes" or arr[1]=="minute"):
        factor=60
      if(arr[1]=="hours" or arr[1]=="hour" ):
        factor=3600 
      if(arr[1]=="seconds" or arr[1]=="second"):
        factor=1
      num_final = int(arr[0]) * factor
      elem_final.append(num_final)
      sum += num_final
      count +=1;
  if  "FINAL_ARCHIVO" in linea:
    var = False
mean = sum/count
print "Termino"
print "Media " + str(mean)
desv_std = 0
for x in elem_final:
  desv_std += ( x - mean ) ** 2
print "Desv std " + str(math.sqrt(desv_std) / count) 
#print elem_final
