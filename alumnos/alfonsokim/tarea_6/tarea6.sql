select
    generate_series as fecha,
    cus.tarjeta as tarjeta,
    (ARRAY['ATM', 'COMERCIO', 'INTERNET'])[trunc(random()*3)+1] as tipo_comercio,
    'colonia ' || ((random() * 10)::integer)::char as colonia,
    (random() * 10000 + 1)::int AS monto
    -- Descomentar para generar la tabla
    -- into transacciones 
from generate_series((now() - '100 days'::interval)::timestamp,     -- 100 dias 
                     now()::date,                                   -- Fecha de inicio
                     -- Salto de la serie; los valores aleatorios son para agregar horas a la
                     -- fecha y que las transacciones no sean cada dia
                     ((((random() * 10) + 1)::integer)::char || ' day')::interval + 
                       ((random() + 1) * '12:00:00'::time)),
(select uuid_generate_v4() as tarjeta from generate_series(1,15)) cus;



drop function IF EXISTS hola(text);
create function hola(name text)
  returns text as $$
    import random
    return 'hola %s!' % name
$$ language plpythonu;


drop function if exists transacciones(integer);
create function transacciones(n integer)
    returns TABLE (
    fecha timestamp, tarjeta varchar ) as $$
    import random
    import uuid
    from datetime import datetime, timedelta

    int_tarjetas = range(15)
    for i in range(n):
        now = datetime.now()
        ri = random.randint
        delta = timedelta(days=ri(1, 10), hours=ri(1, 60), minutes=ri(1, 60), seconds=ri(1, 60))
        fecha = now + delta
        tarjeta = uuid.uuid5(uuid.NAMESPACE_DNS, str(random.choice(int_tarjetas)))
        yield (fecha, tarjeta)

$$ language plpythonu;
