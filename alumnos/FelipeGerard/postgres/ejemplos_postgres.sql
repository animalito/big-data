select
  (generate_series + ((trunc(random()*24) + 1)::text || ':00:00'::text)::time)::timestamp as fecha,
  cus.tarjeta as tarjeta,
  (ARRAY['ATM', 'COMERCIO', 'INTERNET'])[trunc(random()*3)+1] as tipo_comercio,
  (ARRAY['CHA','JA','LOL','HAHA','PEPE','LOI','SIETE','OCHO','NEUF','DIX'])[trunc(random()*10+1)] as colonia,
  (random() * 10000 + 1)::int as monto
into transacciones
from
  generate_series((now() - '100 days'::interval)::date, now()::date, '1 day'::interval),
  (select uuid_generate_v4() as tarjeta from generate_series(1,15)) as cus;



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

