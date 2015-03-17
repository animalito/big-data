#!/bin/bash

# -----------------------------------------------
# Las siguientes instrucciones se 
# deben ejecuta en el docker, con el usuario root
# -----------------------------------------------

# Nuevo usuario, banderas para que no pida los datos
adduser --disabled-password --gecos "" pgdba

# ya que esta creado el usuario se le asigna un
# password, que es el mismo username =S
# AGUAS! No debe haber espacios despues de cada linea
echo "pgdba
pgdba
" | passwd pgdba

# -----------------------------------------------
# Las siguientes instrucciones son con el
# usuario postgres
# -----------------------------------------------

# cambio de usuario
su - postgres

# postgres ya debe estar arriba, fue parte de la tarea anterior
echo "psql -qt -c \"select setting from pg_settings where name = 'hba_file'\" | tr -d '[[:space:]]'" > hba_path
chmod +x hba_path

# Crear super usuario pgdba
psql -qt -c "create role pgdba login password 'pgdba' superuser valid until 'infinity'"

# Respaldar el archivo de configuracion porsi
cp `./hba_path` original_pg_hba.conf

# Configurar el hba_conf
echo "## Configuracion del usuario pgdba" >> `./hba_path`
echo "local     all     pgdba     ident" >> `./hba_path`

# Reiniciar postgres, el directorio de datos esta en el home de postgres
pg_ctl restart -D ./data/

# salir del usuario postgres
exit

# -----------------------------------------------
# Las siguientes instrucciones son con el
# usuario pgdba
# -----------------------------------------------

# Cambio al usuario pgdba
su - pgdba

# Crear la base de datos
psql -d postgres -c "create database ufo"

# Y sus esquemas
echo "\"\$user\"
dirty
clean
shameful
playground
output
mining
ml
extensions" > db_schemas

for schema in `cat db_schemas`
do
    psql -d ufo -c "create schema $schema"
done

# Cambiar el search path de las bds
psql -d ufo -c "alter database ufo set search_path=\"\$user\", dirty, clean, shameful, playground, output, mining, ml, extensions;"

echo "dblink
file_fdw
fuzzystrmatch
hstore
pgcrypto
postgres_fdw
tablefunc
cube
dict_xsyn
pg_trgm
uuid-ossp" > db_extensions

# instalar las extensiones
for extension in `cat db_extensions`
do
    psql -d ufo -c "create extension \"$extension\" schema extensions;"
done

# Crear la otra base de datos; esto seguramente se puede hacer mejor
psql -d postgres -c "create database gdelt"

# Y sus esquemas y extensiones
for schema in `cat db_schemas`
do
    psql -d gdelt -c "create schema $schema"
done

psql -d gdelt -c "alter database ufo set search_path=\"\$user\", dirty, clean, shameful, playground, output, mining, ml, extensions;"

for extension in `cat db_extensions`
do
    psql -d gdelt -c "create extension \"$extension\" schema extensions;"
done

# -----------------------------------------------
# Crear usuarios para las 2 bases de datos
# -----------------------------------------------

psql -d ufo -qt -c "create role ufodba login password 'ufodba' valid until 'infinity'"
psql -d gdelt -qt -c "create role gdeltdba login password 'gdeltdba' valid until 'infinity'"

psql -d ufo -qt -c "GRANT ALL PRIVILEGES ON DATABASE ufo to ufodba"
psql -d gdelt -qt -c "GRANT ALL PRIVILEGES ON DATABASE gdelt to gdeltdba"

exit 

# -----------------------------------------------
# Modificar el archivo de configuracion
# para que los usuarios se puedan conectar remotamente
# -----------------------------------------------

su - postgres
echo "## Configuracion del usuario ufodba" >> `./hba_path`
echo "local     ufo     ufodba     md5" >> `./hba_path`

echo "## Configuracion del usuario gdeltdba" >> `./hba_path`
echo "local     gdelt     gdeltdba     md5" >> `./hba_path`

# Reiniciar
pg_ctl restart -D ./data/

# -----------------------------------------------
# Configuracion del contenedor de docker
# para que funcione como servidor de bd
# -----------------------------------------------

echo "
su - postgres
#!/bin/bash
/usr/lib/postgresql/9.4/bin/pg_ctl start -D ~/data
" >> start_postgres

chmod +x start_postgres

