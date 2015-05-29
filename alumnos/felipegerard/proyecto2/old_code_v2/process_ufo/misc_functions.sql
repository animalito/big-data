
-- Función para checar fechas válidas
CREATE OR REPLACE FUNCTION is_valid_timestamp(text) RETURNS boolean LANGUAGE plpgsql immutable as $$
BEGIN
  RETURN CASE WHEN $1::timestamp IS NULL THEN false ELSE true end;
EXCEPTION WHEN others THEN
  RETURN false;
END;$$;

-- Función para castear fechas
CREATE OR REPLACE FUNCTION ufo_timestamp(origin text, date_time text)
RETURNS timestamp AS $$
BEGIN
	IF substr(origin, 5, 4) = '' THEN RETURN NULL;
	ELSE
		IF substr(origin, 5, 4)::integer < 1970 THEN
			IF is_valid_timestamp($2) THEN RETURN $2::timestamp - interval '100 years'; -- Toma 60 como 2060
	  		ELSE RETURN NULL;
	  		END IF;
	  	ELSE
	  		IF is_valid_timestamp($2) THEN RETURN $2::timestamp;
	  		ELSE RETURN NULL;
	  		END IF;
	  	END IF;
	END IF;
END;
$$ LANGUAGE plpgsql immutable;

