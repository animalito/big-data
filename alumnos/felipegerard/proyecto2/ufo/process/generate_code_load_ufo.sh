
# ALTER DATABASE ufo RENAME TO transacciones;
# CREATE DATABASE ufo WITH TEMPLATE transacciones OWNER felipe;

# GENERAMOS CÓDIGO PARA SUBIR DATOS A LA TABLA SUCIA
find `pwd`/../../data/ufo \
| grep ndxe \
| while read f; do echo '\\'copy dirty.raw_input FROM $f WITH delimiter "'|'" ';'; done > tmp001

echo \
"DROP TABLE IF EXISTS dirty.raw_input;
CREATE TABLE dirty.raw_input (
	date_time varchar,
	city varchar,
	state varchar,
	shape varchar,
	duration varchar,
	summary varchar,
	posted varchar,
	description_url varchar,
	id varchar,
	origin varchar,
	long_description varchar
);" | cat - tmp001 > load_raw_input.sql

rm tmp001


# CREAMOS LA TABLA LIMPIA DE UFO CON SU PARTICIÓN

ls ../../data/ufo | grep ndxe | awk '{gsub(/[^0-9]/,"",$0); $0=substr($0,1,4); if($0=="") $0="1000"; print}' | sort | uniq \
| while read a;
do
echo "CREATE TABLE clean.ufo_$a (CONSTRAINT partition_date_range CHECK (date_time >= '$a-01-01'::date AND date_time <= '$a-12-31'::date)) INHERITS (clean.ufo);"
done > tmp001
echo "
DROP TABLE IF EXISTS clean.ufo CASCADE;
CREATE TABLE clean.ufo (
	origin varchar,
	id varchar,
	date_time timestamp,
	year smallint,
	month smallint,
	day smallint,
	weekday smallint,
	city varchar,
	state varchar,
	shape varchar,
	duration varchar,
	number float,
	units varchar,
	seconds bigint,
	summary varchar,
	posted timestamp,
	description_url varchar,
	long_description varchar
);" | cat - tmp001 > create_ufo_partition.sql

echo "CREATE TABLE clean.ufo_overflow () INHERITS (clean.ufo);" >> create_ufo_partition.sql

rm tmp001

# AHORA LOS TRIGGERS
echo "CREATE OR REPLACE FUNCTION ufo_insert()
RETURNS TRIGGER AS \$f\$
BEGIN
	CASE" > create_ufo_partition_trigger.sql

ls ../../data/ufo| grep ndxe | awk '{gsub(/[^0-9]/,"",$0); $0=substr($0,1,4); if($0=="") $0="1000"; print}' | sort | uniq \
| while read a;
do
echo "WHEN (NEW.date_time >= '$a-01-01'::date AND NEW.date_time <= '$a-12-31'::date) THEN INSERT INTO clean.ufo_$a VALUES (NEW.*);"
done >> create_ufo_partition_trigger.sql

echo "ELSE INSERT INTO clean.ufo_overflow VALUES (NEW.*);" >> create_ufo_partition_trigger.sql

echo "END CASE;
	RETURN NULL;
END; \$f\$ LANGUAGE plpgsql;" >> create_ufo_partition_trigger.sql

echo "CREATE TRIGGER ufo_insert BEFORE INSERT ON clean.ufo
FOR EACH ROW EXECUTE PROCEDURE ufo_insert();" >> create_ufo_partition_trigger.sql


