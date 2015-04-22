
# ALTER DATABASE ufo RENAME TO transacciones;
# CREATE DATABASE ufo WITH TEMPLATE transacciones OWNER felipe;

-- Cargamos la información a una tabla con una columna de texto
CREATE TABLE prueba_input (row varchar);

COPY prueba_input
FROM '/home/felipe/localhost/datos/prueba_ufo.psv';


-- Separamos la columna
select split_part(row, '|', 1) as date_time,
	split_part(row, '|', 2) as city,
	split_part(row, '|', 3) as state,
	split_part(row, '|', 4) as shape,
	split_part(row, '|', 5) as duration,
	split_part(row, '|', 6) as summary,
	split_part(row, '|', 7) as posted,
	split_part(row, '|', 8) as description
into dirty.prueba
from (select row from prueba_input) as t;

-- Limpiamos y guardamos en CLEAN
SELECT
date_time::timestamp,
extract(year from date_time::date) as year, 
extract(month from date_time::date) as month,
extract(day from date_time::date) as day,
extract(dow from date_time::date) as weekday, -- 0 is Sunday
city,
state2 as state,
shape,
duration,
number,
units,
CASE
	WHEN units = 'day' then number*3600*24
	WHEN units = 'hour' then number*3600
	WHEN units = 'min' then number*60
	WHEN units = 'sec' then number*1
END as seconds,
summary,
posted::timestamp,
description
INTO clean.prueba
FROM (SELECT
	*,
	CASE
		WHEN state = '' and city ~ '(.+)' THEN regexp_replace(city, '.+\((.+)\)', '\1')
		ELSE state
	END as state2,
	CASE
		WHEN duration like '%-%' THEN (split_part(regexp_replace(duration, '[^\.0-9\-]', '', 'g'), '-', 1)::float +
			split_part(regexp_replace(duration, '[^0-9\-]', '', 'g'), '-', 2)::float)::float / 2.0
		ELSE regexp_replace(duration, '[^\.0-9]', '', 'g')::float
	END as number,
	CASE
		WHEN duration ~ 'day' then 'day'
		WHEN duration ~ 'hour' then 'hour'
		WHEN duration ~ 'min' then 'min'
		WHEN duration ~ 'sec' then 'sec'
	END as units
	FROM dirty.prueba
	WHERE duration ~ 'day|hour|min|sec' and duration ~ '[0-9]') t;

-- Un query sin las columnas de mucho texto
SELECT date_time, city, state, shape, duration, number, units, seconds, posted FROM clean.prueba;

































