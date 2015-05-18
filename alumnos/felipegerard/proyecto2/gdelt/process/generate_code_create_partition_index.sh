#! /bin/bash
# Recibe ls de GDELT
# $1 = nombre del indice
# $2 = codigo del indice

grep .zip \
| sed -E 's/^([0-9]+)\..*/\1/' \
| awk -v nombre="$1" -v codigo="$2" \
'
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
	print "CREATE INDEX idx_gdelt_" $1 nombre " ON clean.gdelt_" $1 " ( " codigo" );"
    }
    END {
	print "CREATE INDEX idx_gdelt_overflow" nombre " ON clean.gdelt_overflow ( " codigo " );"
    }
'



#CREATE TABLE clean.ufo_1000 (CONSTRAINT partition_date_range CHECK (date_time >= '1000-01-01'::date AND date_time <= '1000-12-31'::date)) INHERITS (clean.ufo);
