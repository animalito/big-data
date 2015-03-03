
import sys
from datetime import datetime, date

# ==================================================================
def safe_parse_date(date_str):
    """
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
    """
    """
    dates.sort()
    streaks = []
    begin = dates[0]
    end = dates[0]
    for current in dates[1:]:
        delta = current - end
        if delta.days == 1:
            end = current
        else:
            if (end - begin).days > 1:
                streaks.append((begin, end, (end - begin).days))
            begin = current
            end = begin
    return sorted(streaks, key=lambda x: -x[2])


# ==================================================================
def parse_streak(state, header=True):
    """
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
    """ Punto de entrada a la consola
    """
    parse_streak(sys.argv[1] if len(sys.argv) > 1 else False)
