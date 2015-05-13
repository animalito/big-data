#! /bin/bash
# Recibe ls de GDELT

grep .zip \
| sed -E 's/^([0-9]+)\..*/\1/' \
| awk -v qte="'" \
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
	print "CREATE TABLE clean.gdelt_" $1 " (CONSTRAINT partition_date_range CHECK (sqldate >= " $2 " AND sqldate <= " $3 ")) INHERITS (clean.gdelt_full);"
    }
    END {
	print "CREATE TABLE clean.gdelt_overflow () INHERITS (clean.gdelt_full);"
    }
'



#CREATE TABLE clean.ufo_1000 (CONSTRAINT partition_date_range CHECK (date_time >= '1000-01-01'::date AND date_time <= '1000-12-31'::date)) INHERITS (clean.ufo);
