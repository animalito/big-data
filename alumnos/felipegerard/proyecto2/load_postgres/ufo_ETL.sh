
# Creamos la tabla sucia
psql -d ufo -f load_raw_input.sql

# Creamos la tabla limpia y sus subtablas. Luego los triggers
psql -d ufo -f create_ufo_partition.sql
psql -d ufo -f create_ufo_partition_trigger.sql

# Funciones auxiliares
psql -d ufo -f misc_functions.sql

# Insertamos en clean.ufo
psql -d ufo -f load_ufo_clean.sql