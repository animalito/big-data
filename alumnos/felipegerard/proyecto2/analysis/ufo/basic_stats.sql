
-- Base original
SELECT count(*)
FROM dirty.raw_input;

-- Tamaño
SELECT count(*)
FROM clean.ufo;

-- Columnas de clean.ufo
SELECT
	column_name,
	data_type
FROM information_schema.columns
WHERE table_schema='clean' and table_name='ufo';

SELECT
	column_name || ','
FROM information_schema.columns
WHERE table_schema='clean' and table_name='ufo';

-- Observaciones
SET SEED 1234;
SELECT
	origin,
	 id,
	 date_time,
	 year,
	 month,
	 day,
	 weekday,
	 city,
	 state,
	 shape,
	 duration,
	 number,
	 units,
	 seconds,
--	 summary,
	 posted
--	 description_url,
--	 long_description,
FROM clean.ufo
WHERE random() < 0.001
LIMIT 100;


-- Summary
SELECT
	count(distinct origin) as num_source_tables,
	min(date_time) as min_date,
	max(date_time) as max_date,
	count(distinct city) as num_cities,
	count(distinct state) as num_states,
	count(distinct shape) as num_shapes,
	min(seconds) as min_duration_seconds,
	max(seconds) as max_duration_seconds
FROM clean.ufo;


-- NULLS
SELECT
	count(*) as total,
	count(origin) FILTER (WHERE origin = '') as origin,
	count(id) FILTER (WHERE id = '') as id,
	count(*) - count(date_time) as date_time,
	count(*) - count(year) as year,
	count(*) - count(month) as month,
	count(*) - count(day) as day,
	count(*) - count(weekday) as weekday,
	count(city) FILTER (WHERE city = '') as city,
	count(state) FILTER (WHERE state = '') as state,
	count(shape) FILTER (WHERE shape = '') as shape,
	count(duration) FILTER (WHERE duration = '') as duration,
	count(*) - count(number) as number,
	count(units) FILTER (WHERE units = '') as units,
	count(*) - count(seconds) as seconds,
	count(summary) FILTER (WHERE summary = '') as summary,
	count(*) - count(posted) as posted,
	count(description_url) FILTER (WHERE description_url = '') as description_url,
	count(long_description) FILTER (WHERE long_description = '') as long_description
FROM clean.ufo;

















