
import sys
from datetime import datetime

# ==================================================================
MONTHS = ',Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dic'.split(',')
DOWS = 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'.split(',') # Monday is 0 and Sunday is 6

TIME_UNITS = {
    'year': (lambda d: d.year, lambda v: str(v)),
    'month': (lambda d: d.month, lambda v: MONTHS[v]),
    'day': (lambda d: d.month, lambda v: str(v)),
    'dow': (lambda d: d.weekday(), lambda v: DOWS[v]), 
    'hour': (lambda d: d.hour, lambda v: str(v)),
    'minute': (lambda d: d.minute, lambda v: str(v))
}

# ==================================================================
def safe_parse_date(date_str):
    """ Intenta convertir un string a fecha usando 2 formatos,
        si no puede devuelve None en lugar de tronar
        :param date_str: La fecha en string
        :return: La fecha si se pudo parsear, None si no
    """
    try:
        return datetime.strptime(date_str, '%m/%d/%y %H:%M')
    except:
        try:
            return datetime.strptime(date_str, '%m/%d/%y')
        except:
            return None


# ==================================================================
def count(time_unit, header=True):
    """ Agrupa los avistamientos por una unidad de tiempo
        :param time_unit: La unidad de tiempo a agrupar
        :param header: Si los datos tienen encabezado
    """
    if header: sys.stdin.readline() 
    line = sys.stdin.readline()
    unit_counter = {}
    while line:
        data = line.strip().split('|')
        date = safe_parse_date(data[0])
        if date:
            unit = TIME_UNITS[time_unit][0](date)
            if unit in unit_counter:
                unit_counter[unit] += 1
            else:
                unit_counter[unit] = 1
        line = sys.stdin.readline()
    for key in sorted(unit_counter, key=unit_counter.get, reverse=True):
        print '%s: %s' % (TIME_UNITS[time_unit][1](key), unit_counter[key])


# ==================================================================
if __name__ == '__main__':
    """ Punto de entrada a la consola. Puede recibir de argumento 
        la unidad de tiempo para agrupar el conteo de avistamientos
    """
    unit = sys.argv[1] if len(sys.argv) > 1 else 'month'
    if unit not in TIME_UNITS:
        print >> sys.stderr, 'Available units: %s' % ','.join(k for k in TIME_UNITS.keys())
        sys.exit(1)
    count(unit)