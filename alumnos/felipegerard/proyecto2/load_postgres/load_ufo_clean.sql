-- Limpiamos e insertamos en ufo limpia

INSERT INTO clean.ufo (
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
	summary,
	posted,
	description_url,
	long_description
)
(
	SELECT
		origin,
		id,
		date_time2 as date_time,
		extract(year from date_time2::date)::smallint as year, 
		extract(month from date_time2::date)::smallint as month,
		extract(day from date_time2::date)::smallint as day,
		extract(dow from date_time2::date)::smallint as weekday, -- 0 is Sunday
		city,
		state2 as state,
		lower(shape) as shape,
		duration,
		number,
		units,
		CASE
			WHEN units = 'day' then t.number*3600*24
			WHEN units = 'hour' then t.number*3600
			WHEN units = 'min' then t.number*60
			WHEN units = 'sec' then t.number*1
		END as seconds,
		summary,
		posted2 as posted,
		description_url,
		long_description
	FROM (SELECT
		*,
		ufo_timestamp(origin, date_time) as date_time2,
		CASE
			WHEN is_valid_timestamp(posted) THEN posted::timestamp
			ELSE NULL
		END as posted2,
		CASE
			WHEN state = '' and city ~ '(.+)' THEN regexp_replace(city, '.+\((.+)\)', '\1')
			ELSE state
		END as state2,
		CASE
			WHEN number_char = NULL THEN -1.0
			WHEN duration ~ '-' THEN (split_part(number_char, '-', 1)::float +
				split_part(number_char, '-', 2)::float)::float / 2.0
			ELSE number_char::float
		END as number,
		CASE
			WHEN duration ~ 'day' then 'day'
			WHEN duration ~ 'hour' then 'hour'
			WHEN duration ~ 'min' then 'min'
			WHEN duration ~ 'sec' then 'sec'
		END as units
		FROM (SELECT *,
			CASE
				WHEN regexp_replace(duration, '[^\-\.0-9]', '', 'g') ~ '(^[0-9]+(\.[0-9]+)?$)|(^[0-9]+(\.[0-9]+)?-[0-9]+(\.[0-9]+)?$)'
					THEN regexp_replace(duration, '[^\.\-0-9]', '', 'g')
				ELSE NULL
			END as number_char
			FROM dirty.raw_input) d
		WHERE duration ~ 'day|hour|min|sec' and duration ~ '[0-9]') t
);

-- INDICE ESPACIO TEMPORAL
CREATE INDEX space_time_ufo_idx ON clean.ufo (
	state, year, month, day, weekday
);






















