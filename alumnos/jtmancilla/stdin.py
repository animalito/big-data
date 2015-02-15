#!/usr/bin/env python

import re
import sys

# while True:
#   linea = sys.stdin.readline()

#   if not linea:
#     break
#   # Hacemos algo con la línea
#   #sys.stdout.write(linea)
#   #sys.stdout.flush()



#n = int(sys.argv[1]) # Leemos un entero como argumento (opcional)
# data = ""
# while 1:
#     try:
#         line = sys.stdin.readline()
#     except KeyboardInterrupt:
#         break

#     if not line:
#         break
#     data += line
#     #print line.upper()
# print data


num=0
for line in sys.stdin:
    regexp = re.compile("-?[0-9]+")
    numeros=[int(i) for i in regexp.findall(line)]

    for j in range(0,len(numeros)):
      num = num + numeros[j]    
    print num
    num=0
#sys.stdout.write(linea)
  #sys.stdout.flush()