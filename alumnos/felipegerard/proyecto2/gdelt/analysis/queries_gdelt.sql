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

-- COMPARAR VS OTROS PAISES (VERSION 1)
-----------------------------------

EXPLAIN ANALYZE SELECT
    monthyear,
    actor1name,
--    actor1geo_fullname,
--    actor2name,
--    actor2geo_fullname,
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
--INTO output.monthyear_actors_count_full
FROM clean.gdelt_full -- (select * from clean.gdelt_full limit 1000000) as t1
WHERE actor1name != '' -- OR actor1geo_fullname != '' OR actor2name != '' OR actor2geo_fullname != ''
GROUP BY monthyear, actor1name --, actor1geo_fullname;
--, actor2name, actor2geo_fullname
ORDER BY monthyear, actor1name; --, actor1geo_fullname; --, actor1geo_fullname, actor2name, actor2geo_fullname;


-- COMPARAR VS OTROS PAISES (VERSION 2)
-----------------------------------

EXPLAIN ANALYZE SELECT
    monthyear,
    actor1countrycode,
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
INTO output.monthyear_actor1countrycode_stats_full
FROM clean.gdelt_full
WHERE actor1countrycode != ''
GROUP BY monthyear, actor1countrycode
ORDER BY monthyear, actor1countrycode;



-- PRIMER EVENTO POR PAIS (ACTOR1NAME EN ESTE CASO)
---------------------------------------------------
drop table playground.prueba;
SELECT globaleventid, actor1name, sqldate INTO playground.prueba FROM clean.gdelt_full LIMIT 100000;
--EXPLAIN SELECT globaleventid, actor1name, sqldate FROM clean.gdelt_full LIMIT 10000;

-- OPCION 1: ORDENAR Y QUEDARNOS CON EL PRIMERO
EXPLAIN ANALYZE WITH grouped as (
    SELECT
	globaleventid,
	actor1name,
	sqldate,
	row_number() OVER (PARTITION BY actor1name ORDER BY sqldate) AS row_num
    FROM playground.prueba --clean.gdelt_full
)
(
    SELECT
	globaleventid,
	actor1name,
	sqldate
    FROM grouped
    WHERE row_num = 1
);

-- OPCION 2: ORDENAR Y QUEDARNOS CON EL PRIMERO DEL OUTPUT MENSUAL. PEGAR A LA TABLA GRANDE Y FILTRAR.

-- a. Primeros meses
EXPLAIN ANALYZE WITH grouped as (
    SELECT
	actor1countrycode,
	actor1countryname,
	monthyear,
	row_number() OVER (PARTITION BY actor1countrycode ORDER BY monthyear) AS row_num
    FROM output.monthyear_actor1countrycode_stats_full_countryname --playground.prueba --clean.gdelt_full
)
(
    SELECT
	actor1countrycode,
	actor1countryname,
	monthyear
    INTO playground.first_months
    FROM grouped
    WHERE row_num = 1
);

-- b. Filtramos la base grande
drop table playground.gdelt_part;
select * into playground.gdelt_part from clean.gdelt_full limit 1000000;
EXPLAIN ANALYZE WITH
months AS (
    SELECT distinct monthyear
    FROM playground.first_months
    ORDER BY monthyear
),
filtered AS(
    SELECT
	a.globaleventid,
	a.sqldate,
	a.actor1countrycode
    FROM clean.gdelt_full a INNER JOIN months b
    ON a.monthyear = b.monthyear
),
grouped as (
    SELECT
	*,
	row_number() OVER (PARTITION BY actor1countrycode ORDER BY sqldate) AS row_num
    FROM filtered
)
(
    SELECT *
    INTO output.first_event_per_actor1countrycode_full
    FROM grouped
    WHERE row_num = 1
);

-- Para no correr el query anterior de nuevo. Lo que pasa es que me había faltado seleccionar todas las columnas de la tabla
EXPLAIN ANALYZE SELECT *
INTO output.first_event_per_actor1countrycode_full
FROM clean.gdelt_full
WHERE globaleventid in ('59','74','78','108','137','146','176','183','184','195','255','257','267','268','277','280','287','323','340','359','369','387','391','394','395','396','399','423','426','438','441','444','447','448','449','515','541','548','554','568','674','677','678','679','680','682','683','704','773','802','830','839','848','882','1003','1014','1059','1072','1175','1197','1211','1268','1269','1279','1282','1300','1321','1326','1477','1501','1610','1623','1628','1632','1634','1638','1753','1842','1873','1983','1998','2002','2012','2018','2019','2156','2157','2163','2165','2235','2244','2245','2267','2271','2327','2332','2337','2663','2682','2796','2811','2962','3026','3043','3176','3188','3799','3939','4065','4125','4132','4146','4166','4242','4524','4868','5297','5984','5987','6219','6657','6658','6732','6873','7074','7228','7357','7411','7711','7868','7870','8048','8058','8460','8461','8464','8847','9656','9863','9928','9979','10013','10353','10584','11106','11185','11306','12076','12681','13487','13649','13835','14834','15503','17301','18415','21156','21755','24556','27420','30014','30209','30949','31753','32595','33536','33546','34336','38606','40682','52256','52635','54749','63134','65147','76289','82277','98959','107161','112742','131039','134733','145512','151920','191729','204809','244016','329880','355098','374721','396871','493889','571647','580229','2546139','2837629','3348143','5351018','8376729','17602012','18618212','23249148','47719459','179990792','230362055','230362059','230362076','230362089','230362108','230362120','230362124','230362140','230362141','230362143','230362160','230362208','230362368','230362492','230363108','230363603','230363683','230364208','230366693','273501446','305640553')
LIMIT 225;


\copy output.first_event_per_actor1countrycode_full to '/Users/Felipe/big-data/alumnos/felipegerard/proyecto2/output/first_event_per_actor1countrycode_full.psv' CSV HEADER DELIMITER '|';


-- Estadísitcas mensuales de número eventos por país
-------------------------------------------
-- Usaremos output.monthyear_actors_count_full que ya está por mes para ahorrar tiempo

EXPLAIN ANALYZE SELECT
    actor1name,
    sum(numevents) as tot_numevents,
    avg(numevents) as avg_numevents,
    min(numevents) as min_numevents,
    max(numevents) as max_numevents
INTO output.month_actor1name_event_stats
FROM output.monthyear_actors_count_full
GROUP BY actor1name
ORDER BY actor1name;



-- STATS
SELECT
    userid,
    dbid,
    queryid,
    --query,
    rows,
    round(total_time) as milliseconds,
    round((total_time / 1000.0)::numeric, 1) as seconds,
    round((total_time / 1000.0 / 60.0)::numeric, 2) as minutes
FROM pg_stat_statements LIMIT 100;







