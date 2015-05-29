-- SOLO LAS COLUMNAS BASICAS
CREATE VIEW clean.basic_mex AS
SELECT
    globaleventid,
    sqldate,
    isrootevent,
    actor1name,
    actor1geo_countrycode,
    actor1geo_fullname,
    goldsteinscale,
    nummentions,
    numsources,
    avgtone,
    actor2name,
    actor2geo_countrycode,
    actor2geo_fullname
FROM clean.gdelt_mex;

-- TEMPORAL
-----------------------------------
SELECT
    sqldate::varchar::date as date,
    substr(sqldate::varchar,1,4) as year,
    substr(sqldate::varchar,5,2) as month,
    substr(sqldate::varchar,7,2) as day,
    count(sqldate) as count
INTO output.date_count
FROM clean.gdelt_mex
GROUP BY sqldate
ORDER BY sqldate;
-- EXPORTAMOS
\copy (select * from output.date_count) TO '/home/felipe/localhost/output/gdelt_date_count.psv' DELIMITER '|' NULL '' CSV HEADER;

-- ESPACIO-TEMPORAL?
-----------------------------------
WITH t1 AS (
    SELECT
	year,
	actor1name,
	goldsteinscale,
	nummentions,
	numsources,
	avgtone,
	actor2name,
	CASE
	    WHEN actor1geo_fullname ~ 'Mexico' THEN regexp_replace(actor1geo_fullname, '(^.+, )(.+)(, Mexico$)', '\2')
	    WHEN actor2geo_fullname ~ 'Mexico' THEN regexp_replace(actor2geo_fullname, '(^.+, )(.+)(, Mexico$)', '\2')
	    ELSE ''
	END as state
    FROM clean.gdelt_mex
    WHERE actor1geo_fullname ~ ', Mexico' or actor2geo_fullname ~ ', Mexico'
)
(
    SELECT
	year,
	state,
	count(year) as numevents,
	avg(goldsteinscale) as goldsteinscale,
	sum(nummentions) as nummentions,
	sum(numsources) as numsources,
	avg(avgtone) as avgtone
    INTO output.state_year_count
    FROM t1
    GROUP BY year, state
    ORDER BY year, state
);

-- EXPORTAMOS
\copy (select * from output.state_year_count) TO '/home/felipe/localhost/output/gdelt_state_year_count.psv' DELIMITER '|' NULL '' CSV HEADER;











