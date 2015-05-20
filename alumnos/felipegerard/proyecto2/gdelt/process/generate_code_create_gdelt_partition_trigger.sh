#! /bin/bash
# Recibe ls de GDELT

grep .zip \
| sed -E 's/^([0-9]+)\..*/\1/' \
| awk -v qte="'" \
'   
    BEGIN {
	print "CREATE OR REPLACE FUNCTION gdelt_insert() \
	RETURNS TRIGGER AS \$f\$ \
	BEGIN \
	CASE"
    }
    {
	if(length($1) == 4){
	    $2 = $1 "0101";
	    $3 = $1 "1231";
	    $1 = $1 "0000"
	} else if(length($1) == 6){
	    $2 = $1 "01";
	    $3 = $1 "31";
	    $1 = $1 "00"
	} else if(length($1) == 8){
	    $2 = $1;
	    $3 = $1;
	}
	print "WHEN (NEW.sqldate >= " $2 " AND NEW.sqldate <= " $3 ") THEN INSERT INTO clean.gdelt_" $1 " VALUES (NEW.*);"
    }
    END {
	print "ELSE INSERT INTO clean.gdelt_overflow VALUES (NEW.*); \
	END CASE; \
	RETURN NULL; \
	END; \$f\$ LANGUAGE plpgsql; \
	CREATE TRIGGER gdelt_insert BEFORE INSERT ON clean.gdelt_full \
	FOR EACH ROW EXECUTE PROCEDURE gdelt_insert();"
    }
'


#WHEN (NEW.date_time >= '2005-01-01'::date AND NEW.date_time <= '2005-12-31'::date) THEN INSERT INTO clean.ufo_2005 VALUES (NEW.*);
#CREATE TABLE clean.ufo_1000 (CONSTRAINT partition_date_range CHECK (date_time >= '1000-01-01'::date AND date_time <= '1000-12-31'::date)) INHERITS (clean.ufo);
