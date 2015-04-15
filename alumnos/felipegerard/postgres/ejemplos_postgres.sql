
------------------
-- TRANSACCIONES
select
  (fec.dia + ((trunc(random()*24) + 1)::text || ':00:00'::text)::time)::timestamp as fecha, -- AGREGAMOS LA HORA
  cus.tarjeta as tarjeta,
  (ARRAY['ATM', 'COMERCIO', 'INTERNET'])[trunc(random()*3)+1] as tipo_comercio,
  (ARRAY['CHA','JA','LOL','HAHA','PEPE','LOI','SIETE','OCHO','NEUF','DIX'])[trunc(random()*10+1)] as colonia, -- COLONIA
  (random() * 10000 + 1)::int as monto,
  9*random() < substring(tarjeta::text from '[0-9]')::int + 1 as include
into temp1 --transacciones
from
  (select generate_series((now() - '100 days'::interval)::date, now()::date, '1 day'::interval) as dia) as fec,
  (select uuid_generate_v4() as tarjeta from generate_series(1,15)) as cus
;--where 9*random() < substring(tarjeta::text from '[0-9]')::int + 1; -- LAS TARJETAS TRANSACCIONAN AL AZAR. DEPENDIENDO DEL ID UNAS TRANSACCIONAN MAS, IE. LA MEDIA DE LAS TARJETAS NO ES IGUAL
-- POR QUE SI PONGO LA CONDICION DIRECTO EN EL WHERE FILTRA TARJETAS EN LUGAR DE REGISTROS?

select *
into transacciones
from temp1
where include;


----------------
-- CROSSTABS
select *
from crosstab(
'select                      -- source sql
date_part(''year'', fecha),
date_part(''month'', fecha),
tipo_comercio,
monto from transacciones
order by 1',
'select                      -- category sql
distinct tipo_comercio
from transacciones'
)
as                           -- tabla de salida
( year int,
  month int,
  ATM int,
  COMERCIO int,
  INTERNET int
);

----------------------
-- Peliculas cercanas a Apocalypse Now
SELECT title, cube_distance(genre, (select genre from movies where title='Apocalypse Now')::cube) dist
FROM movies
WHERE cube_enlarge((select genre from movies where title='Apocalypse Now')::cube, 5, 18) @> genre
ORDER BY dist;

-- Ahora con distancia de Levenshtein INCOMPLETO
--SELECT title, cube_distance(genre, (select genre from movies where title='Apocalypse Now')::cube) dist
--FROM movies
--WHERE cube_enlarge((select genre from movies where title='Apocalypse Now')::cube, 5, 18) @> genre
--ORDER BY dist;

-----------------------
-- Ejemplo JSON
select row_to_json(tabla)
from (
     select actor_id, name,
     (
        select array_to_json(array_agg(row_to_json(jd)))
        from (
             select movie_id, title, genre
             from movies
             natural join movies_actors ma
             where  ma.actor_id = j.actor_id
        ) as jd
     ) as peliculas
     from actors j
) as tabla;

----------------------
-- Version mejorada de transacciones en python
CREATE OR REPLACE FUNCTION generate_card_transactions(num_cards integer, days integer, min_trans integer, max_trans integer, mean_amount float, sd_amount float,
       				           OUT timestamp, OUT uuid, OUT text, OUT text, OUT float)
RETURNS setof record
AS $$
import uuid
import datetime
import random
cards = [uuid.uuid1() for i in range(num_cards)]
a = datetime.datetime.now()
today = datetime.datetime(year=a.year, month=a.month, day=a.day)
dates = [today - datetime.timedelta(days = x) for x in range(days, 0, -1)]
trans = {}
trans['fecha'] = [d + datetime.timedelta(seconds=s) for d in dates for s in [random.gauss(3600*24/2, 3600*24/4) for x in range(int((max_trans - min_trans)*random.random()) + min_trans)]]
trans['tarjeta'] = [random.choice(cards) for i in range(len(trans['fecha']))]
trans['tipo_comercio'] = [random.choice(['ATM', 'COMERCIO', 'INTERNET']) for i in range(len(trans['fecha']))]
trans['colonia'] = [random.choice(['CHA','JA','LOL','HAHA','PEPE','LOI','SIETE','OCHO','NEUF','DIX']) for i in range(len(trans['fecha']))]
trans['monto'] = [max(0.01, round(random.gauss(mean_amount, sd_amount), 2)) for i in range(len(trans['fecha']))]
return [(trans['fecha'][i], trans['tarjeta'][i], trans['tipo_comercio'][i], trans['colonia'][i], trans['monto'][i]) for i in range(len(trans['fecha']))]
$$ LANGUAGE plpythonu;

-- Query para generar la base de transacciones usando la funcion anterior
select * from  generate_card_transactions(20,100,10,100,1000,500) as a(fecha, tarjeta, tipo_comercio, colonia, monto) limit 10;

select *
into transacciones2
from  generate_card_transactions(20,100,10,100,1000,500) as a(fecha, tarjeta, tipo_comercio, colonia, monto)
order by fecha;
