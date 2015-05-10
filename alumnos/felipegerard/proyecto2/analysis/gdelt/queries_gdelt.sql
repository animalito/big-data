-- Vista de campos mas importantes
CREATE VIEW clean.basic_full AS
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
FROM clean.gdelt_full;

-- Tamanio de las tablas
SELECT schemaname,relname,n_live_tup 
FROM pg_stat_user_tables 
ORDER BY n_live_tup DESC;

-- Columnas de las tablas
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema='clean' and table_name='gdelt_full';

-- Columnas mas importantes
SELECT *
FROM clean.basic_full
LIMIT 100;

-- Conteo de nulos
EXPLAIN ANALYZE SELECT
    count(*) as numrow,
--    count(distinct globaleventid) as numevent, -- Esto es MUY tardado
    min(sqldate) as mindate,
    max(sqldate) as maxdate,
    count(sqldate = NULL) as nulldate,
    sum(isrootevent::integer) as numrootevents,
    sum(1 - isrootevent::integer) as numnonrootevents,
--    count(distinct actor1name) numactor1, -- Tardado
    sum((actor1name = '')::integer) as numnullactor1,
--    count(distinct actor1geo_countrycode) as numactor1geo_countrycode, -- Tardadp
    sum((actor1geo_countrycode = '')::integer) as numnullactor1geo_countrycode,
--    count(distinct actor1geo_fullname) as numactor1geo_fullname,
    sum((actor1geo_fullname = '')::integer) as numnullactor1geo_fullname,
    avg(goldsteinscale) as meangoldsteinscale,
    stddev(goldsteinscale) as sdgoldsteinscale,
    min(nummentions) as minnummentions,
    max(nummentions) as maxnummentions,
    avg(nummentions) as meannummentions,
    min(numsources) as minnumsources,
    max(numsources) as maxnumsources,
    avg(numsources) as meannumsources,
    avg(avgtone) as avgtone,
--    count(distinct actor2name) as numactor2,
    sum((actor2name = '')::integer) as numnullactor2,
--    count(distinct actor2geo_countrycode) as numactor2geo_countrycode,
    sum((actor2geo_countrycode = '')::integer) as numnullactor2geo_countrycode,
--    count(distinct actor2geo_fullname) as numactor2geo_fullname,
    sum((actor2geo_fullname = '')::integer) as numnullactor2geo_fullname
INTO output.conteos_gdelt_full
FROM clean.gdelt_full; -- (SELECT * FROM clean.gdelt_full LIMIT 100000) t;
--INTO output.conteos_gdelt_full

-- ESPACIO-TEMPORAL?
-----------------------------------

EXPLAIN ANALYZE SELECT
    monthyear,
    actor1name,
    actor1geo_fullname,
    actor2name,
    actor2geo_fullname,
    count(*) as numevents,
    avg(goldsteinscale) as goldsteinscale,
    min(goldsteinscale) as min_goldsteinscale,
    max(goldsteinscale) as max_goldsteinscale,
    sum(nummentions) as nummentions,
    sum(numsources) as numsources,
    avg(avgtone) as mean_avgtone,
    stddev(avgtone) as sd_avgtone,
    min(avgtone) as min_avgtone,
    max(avgtone) as max_avgtone
INTO output.monthyear_actors_count_full
FROM clean.gdelt_full -- (select * from clean.gdelt_full limit 100000) as t1
WHERE actor1name != '' OR actor1geo_fullname != '' OR actor2name != '' OR actor2geo_fullname != ''
GROUP BY monthyear, actor1name, actor1geo_fullname, actor2name, actor2geo_fullname
ORDER BY monthyear, actor1name, actor1geo_fullname, actor2name, actor2geo_fullname;
