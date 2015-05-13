#!/usr/bin/env python

# --------------------------------------------------------------------------------
def generate_random_numbers(n, max_num=1000):
    """ Crea una lista inicial de enteros
        :param n: El numero de enteros a gener
        :param max_num: Numero maximo a generar. Default 1000
    """
    import random
    return [random.randint(0, max_num) for _ in range(n)]

# --------------------------------------------------------------------------------
def calculate_max(numbers):
    """ Calcula el maximo
        :param numbers: La lista de enteros
    """
    return reduce((lambda x, y: x if x > y else y), numbers) 

# --------------------------------------------------------------------------------
def world_count(numbers):
    """ Cuenta las ocurrencias de un numero en la lista
        :param numbers: La lista de enteros
        :return: Un diccionario donde las llaves son los numeros y 
                 los valores son las veces que ocurrieron
    """
    worlds = {}
    def sum_reduce(x):
        """ El reductor: Se actualiza la lista de numeros con las veces que 
            ocurre cada numero
        """
        if x in worlds: worlds[x] += 1
        else: worlds[x] = 1
    map(sum_reduce, numbers) # Map no devuelve nada ya que el reductor no devuelve 
    return worlds

# --------------------------------------------------------------------------------
def average(numbers):
    """ Calcula el promedio de la lista
        :param numbers: La lista de enteros
    """
    values = map(lambda x: (1, x), numbers)
    count, num_sum = reduce(lambda x, y: (x[0] + y[0], x[1] + y[1]), values)
    return float(num_sum) / count

# --------------------------------------------------------------------------------
def standard_deviation(numbers):
    """ Calcula la desviacion estandar de la lista
        :param numbers: La lista de enteros
    """
    avg = average(numbers)
    square_diffs = map(lambda x: (x - avg) ** 2, numbers)
    return reduce(lambda x, y: x + y, square_diffs) ** 0.5

# --------------------------------------------------------------------------------
def top_n(numbers, n):
    """ Calcula el top n de la lista
        :param numbers: La lista de enteros
        :param n: El numero de valores a encontrar
    """
    num_set = set(numbers)
    top = []
    # No me gusto que sea iterativo, si puedo lo arreglo
    while len(top) < n and num_set:
        max_n = calculate_max(num_set)
        num_set.remove(max_n)
        top.append(max_n)
    return top

# --------------------------------------------------------------------------------
if __name__ == '__main__':
    """ Punto de entrada. Crea una lista de numeros
        y llama a cada metodo para probar
    """
    big_set = generate_random_numbers(100, max_num=100)
    print 'Conjunto inicial: %s' % str(big_set)
    print 'Max: %s' % calculate_max(big_set)
    print 'WC: %s' % world_count(big_set)
    print 'Avg: %s' % average(big_set)
    print 'SD: %s' % standard_deviation(big_set)
    print 'Top 10: %s' % top_n(big_set, 10)

