
import sys
from datetime import datetime, date

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
def build_streaks(dates):
    """ Encuentra las rachas en una lista de fechas
        :param dates: La lista de fechas
    """
    dates.sort()
    streaks = []
    if len(dates) == 0: return []
    begin = dates[0]
    end = dates[0]
    for current in dates[1:]:
        delta = current - end
        if delta.days == 1: # Sigue la racha
            end = current
        else:       # Fin de la racha
            if (end - begin).days > 1: # Es racha solo si la dif de dias es mayor a 1
                streaks.append((begin, end, (end - begin).days))
            begin = current
            end = begin
    return sorted(streaks, key=lambda x: -x[2])


# ==================================================================
def parse_streak(state, header=True):
    """ Procesa las rachas de un estado, o de todos si no se
        especifica ninguno
        :param state: El estado a encontrar, o None si se buscan todos
        :param header: Si los datos tienen encabezado
    """
    #print 'Max streaks for state %s' % (state or 'all')
    if header: sys.stdin.readline() 
    line = sys.stdin.readline()
    dates = []
    while line:
        data = line.strip().split('|')
        if len(data) > 2:
            filter_state = state if state else data[2]
            date = safe_parse_date(data[0])
            if date and data[2] == filter_state:
                dates.append(date)
        line = sys.stdin.readline()
    for streak in build_streaks(dates):
        print '%s-%s: %s' % (streak[0].strftime('%d/%m/%y'), streak[1].strftime('%d/%m/%y'), streak[2])



# ==================================================================
if __name__ == '__main__':
    """ Punto de entrada a la consola. Puede recibir de argumento 
        el codigo de pais al que se busca la racha
    """
    parse_streak(sys.argv[1] if len(sys.argv) > 1 else False)
