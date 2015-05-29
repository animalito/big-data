-- INDICE ESPACIO TEMPORAL
CREATE INDEX space_time_ufo_idx ON clean.ufo (
   sqldate,
   actor1name,
   actor1geo_fullname,
   actor2name,
   actor2geo_fullname,
   goldsteinscale,
   avgtone
);
