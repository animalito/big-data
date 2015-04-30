-- Base de EUA

CREATE MATERIALIZED VIEW clean.ufo_usa AS
SELECT * 
FROM clean.ufo
WHERE state in (
'AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA',
'KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ',
'NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT',
'VA','WA','WV','WI','WY','AS','DC','FM','GU','MH','MP','PW','PR','VI');


-- Primer avistamiento de cada estado

WITH grouped AS (
	SELECT *,
		row_number() OVER (PARTITION BY state
							ORDER BY state, date_time) AS row_num
	FROM clean.ufo_usa
)
(SELECT
	origin,
	id,
	date_time,
	year,
	month,
	day,
	weekday,
	city,
	state,
	shape
FROM grouped
WHERE row_num = 1
ORDER BY state, date_time);


-- Primer avistamiento de cada forma

WITH grouped AS (
	SELECT *,
		row_number() OVER (PARTITION BY shape
							ORDER BY shape, date_time) AS row_num
	FROM clean.ufo_usa
)
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
	shape
FROM grouped
WHERE row_num = 1
ORDER BY shape, date_time;


-- Avistamientos por mes
SELECT
	year,
	month,
	count(*) as sightings
FROM clean.ufo_usa
WHERE year is not NULL and month is not NULL
GROUP BY year, month;


-- Avistamientos por año
SELECT
	year,
	count(*) as sightings
FROM clean.ufo_usa
WHERE year is not NULL
GROUP BY year

-- Avistamientos por estado

SELECT
state,
count(*) as sightings
FROM clean.ufo_usa
GROUP BY state
ORDER BY state;


-- Estado con mayor varianza (entre avistamientos por mes)

WITH s as
(
	SELECT
	state,
	year,
	month,
	count(*) as sightings
	FROM clean.ufo_usa
	GROUP BY state, year, month
	ORDER BY state, year, month
)
(
	SELECT
	state,
	sum(sightings) as freq,
	round(avg(sightings),3) as mean,
	round(stddev(sightings),3) as std_dev,
	round(stddev(sightings)/avg(sightings),3) as std_dev_over_mean

	FROM s
	GROUP BY state
	ORDER BY std_dev_over_mean desc
);





