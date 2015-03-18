#!/usr/bin/env python

import sys
from datetime import datetime
import matplotlib.pyplot as plt


# ==================================================================
def safe_parse_date(date_str):
    """ Intenta convertir un string a fecha usando 2 formatos,
        si no puede devuelve None en lugar de tronar
        :param date_str: La fecha en string
    """
    try:
        return datetime.strptime(date_str, '%m/%d/%y %H:%M')
    except:
        try:
            return datetime.strptime(date_str, '%m/%d/%y')
        except:
            return None


# ==================================================================
def plot_timeseries(time_series, name):
    """ Grafica la serie de tiempo dada en un archivo png 
        :param time_series: La serie de tiempo a graficar
        :param name: El nombre de la serie de tiempo, el archivo
                     de salida tiene este nombre
    """
    x = [v[0] for v in time_series]
    y = [v[1] for v in time_series]
    max_views = max(y)
    plt.plot_date(x, y, fmt="r-")
    plt.title('Serie de tiempo para %s' % name)
    plt.ylabel('Avistamientos')
    plt.grid(True)
    plt.savefig('%s.png' % name)


# ==================================================================
def create_timeseries(state, header=True):
    """ Crea la serie de tiempo con datos de la entrada estandar
        :param state: El estado a generar la serie de tiempo, 
                      si es None se procesa para todos los datos
        :param header: Si los datos tienen encabezado
    """
    if header: sys.stdin.readline() 
    line = sys.stdin.readline()
    time_series = {}
    while line:
        data = line.strip().split('|')
        if len(data) > 2:
            filter_state = state if state else data[2]
            date = safe_parse_date(data[0])
            if date and date < datetime.now() and data[2] == filter_state:
                key = date.date()
                if key in time_series: time_series[key] += 1
                else: time_series[key] = 1
        line = sys.stdin.readline()
    return [(sk, time_series[sk]) for sk in sorted(time_series.keys())]


# ==================================================================
if __name__ == '__main__':
    """ Punto de entrada a la consola. Puede recibir de argumento 
        el codigo de pais al que se va a procesar la serie de tiempo
    """
    state = sys.argv[1] if len(sys.argv) > 1 else None
    ts = create_timeseries(state)
    plot_timeseries(ts, state or 'USA')
