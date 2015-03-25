-- Funcion de plpython para generar transacciones
-- con distribuciones normales
-- USO: SELECT <campos> FROM transacciones(n)
--      campos: Los campos de la tabla:
--              - fecha (timestamp): Fecha operacion
--              - tarjeta (varchar): Numero de tarjeta seleccionado normalmente de entre 20
--              - tipo_comercio (varchar): Tipo de comercio seleccionado normalmente de entre ATM, COMERCIO, INTERNET
--              - colonia (varchar): Colonia con formato 'colonia %i' seleccionado de entre 10 colonias
--              - monto (float): Importe de la operacion, generado normalmente con mu=10000 y sigma=100
--      n: Numero de registros a generar

drop function if exists transacciones(integer);
create function transacciones(n integer)
    returns TABLE (
    fecha timestamp, tarjeta varchar, tipo_comercio varchar,
    colonia varchar, monto float ) as $$

    import random
    import uuid
    from datetime import datetime, timedelta

    int_tarjetas = range(20)
    tipo_comercio = ['ATM', 'COMERCIO', 'INTERNET']
    now = datetime.now()
    
    for i in range(n):
        ri = random.randint
        rg = random.gauss
        delta = timedelta(days=ri(1, 10), hours=ri(1, 60), minutes=ri(1, 60), seconds=ri(1, 60))
        fecha = now + delta
        tarjeta_idx = int(rg(len(int_tarjetas), 1)) % len(int_tarjetas)
        comercio_udx = int(rg(len(tipo_comercio), 1)) % len(tipo_comercio)
        tarjeta = uuid.uuid5(uuid.NAMESPACE_DNS, str(int_tarjetas[tarjeta_idx]))
        comercio = tipo_comercio[comercio_udx]
        colonia = 'Colonia %s' % (int(rg(20, 1) % 10) + 1)
        monto = rg(10000, 5000) + 1
        yield (fecha, tarjeta, comercio, colonia, monto)

$$ language plpythonu;
