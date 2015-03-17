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

# Reiniciar postgres
pg_ctl restart -D ./data/
