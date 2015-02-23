#!/usr/bin/env python

import sys
import re

# ==============================================================
## Expresiones regulares para el parseo de la fecha
HOUR_MINUTE_SECOND = r'([0-9][0-9]?):([0-9]+):([0-9]+)(.*)'
MINUTE_SECOND = r'([0-9]+):([0-9]+)(.*)'
IN_RANGE = r'([0-9]+)-([0-9]+) *(.*)'
PLAIN_TIME = r'([0-9]+) *(.*)'


# ==============================================================
def get_units(units):
    """ :units units: El string con las unidades
        :return: El factor a multiplicar para obtener segundos
        :raise: En caso de que las unidades no sean conocidas
    """
    if units[0:3] == 'hou': return 60 * 60
    if units[0:3] == 'min': return 60
    if units[0:3] == 'sec': return 1
    if units[0:4] == 'mill': return 1 / 1000
    raise Exception('units not regular: %s' % units)


# ==============================================================
def parse(maybe_time):
    """ Parsea la cadena para estandarizar el tiempo en segundos
        recibiendo los distintos formatos que vienen en el archivo
        :param maybe_time: La cadena con el posible lapso
        :return: El tiempo en segundos del lapso dado
        :raise: En caso de que la cadena no sea regular
    """
    match = re.match(HOUR_MINUTE_SECOND, maybe_time)
    if match:
        return (int(match.group(1)) * 60 * 60) + (int(match.group(2)) * 60) + int(match.group(3))
    match = re.match(MINUTE_SECOND, maybe_time)
    if match:
        return (int(match.group(1)) * 60) + int(match.group(2))
    match = re.match(IN_RANGE, maybe_time)
    if match:
        time = (int(match.group(1)) + int(match.group(2))) / 2
        units = get_units(match.group(3))
        return time * units
    match = re.match(PLAIN_TIME, maybe_time)
    if match:
        time = int(match.group(1))
        units = get_units(match.group(2))
        return time * units
    raise Exception('time not regular: %s' % maybe_time)


# ==============================================================
def main():
    """ Parseo de las lineas que vienen de la entrada estandarizar
        Al finalizar la lectura de lineas escribe el analisis de tiempo
        Escribe en un archivo 'raros.txt' las lineas que no pudo
        parsear para su revision manual.
    """
    line = sys.stdin.readline()
    manual = open('raros.txt', 'w')
    num_lines = 0
    a_sum = 0
    a_sum_sq = 0
    a_min = 10000000000000
    a_max = 0
    while line:
        num_lines += 1
        line = line.lower().replace('few', '10').replace('~', '') ## Mismo tratamiento que con el tr
        line = line.replace('+', '').replace('<', '').replace('>', '').strip() ## y con sed
        try:
            seconds = parse(line)
            if seconds < a_min: a_min = seconds
            if seconds > a_max: a_max = seconds
            a_sum += seconds
            a_sum_sq += seconds * seconds
        except Exception, e:
            num_lines -= 1
            print >> manual, line
        line = sys.stdin.readline()
    manual.close()
    print 'MIN:%is, MAX:%is, AVG:%.2fs, STDDEV:%.2fs' % (a_min, a_max, (a_sum / num_lines), 
                                                        ((a_sum_sq / num_lines) - (a_sum / num_lines)**2)**0.5) 


# ==============================================================
if __name__ == '__main__':
    """ Punto de entrada de la consola. Sin argumentos
    """
    main()
