Big data :: Lecture 3
========================================================
author: Adolfo De Unánue T.
date: 4 de marzo, 2015
font-import: http://fonts.googleapis.com/css?family=Risque
font-family: 'Risque'
css: ../css/itam_big_data.css



========================================================
type: exclaim

## Bases de datos




Bases de datos
=========================================================
* Un RDBMS es la solución para datos no tan grandes...
    - Pero mas grandes que MS Excel.
* Adecuada para todas las tareas
    - Pero no es excelente en ninguna.
* Fácil de usar
    - Pocos requerimientos de HW.
    - Soporte en casi todos los lenguajes.
    - Todo el mundo la conoce.
* En realidad, no puede hacer big, big data.

Bases de datos Relacionales
=========================================================

- **Edward F. Codd**
  - Héroes verdaderos, no como *Steve Jobs*.

- Contienen *relaciones* (`tablas`), las cuales tienen un conjunto de *tuplas* (`renglones`), las cuales
mapean *atributos* a valores *atómicos*, los cuales quedan definidos por una *tupla header* mapeado a un *dominio* (`columnas`).

- Originalmente `booleanas`, la implementación actual es `logica trivaluada` (`TRUE`, `FALSE`, `NULL`).


Bases de datos Relacionales
=========================================================

- No son **relacionales** por que las tablas estén relacionadas por campos y restricciones.

- Son **relacionales**  por que están construidas sobre la rama matemática de *álgebra relacional*.

- Aunque en la implementación es simplificada a la rama de *cálculo relacional de tuplas* el cuál se puede convertir en *álgebra relacional*.

========================================================
type: exclaim

## PostgreSQL

¿Por qué PostgreSQL?
========================================================

* Open-source
* Es una base de datos orientada a objetos.
* Varios tipos de [índices](http://www.postgresql.org/docs/9.3/static/indexes.html)
* `JOIN`s optimizados
    - 5 diferentes tipos de joins
    - Soporta optimizaciones (vía GA) de más de 20 tablas.
* Subqqueries en cualquier cláusula.
* Subqueries anidados.
* Windowing functions
* Geoespacial

¿Por qué PostgreSQL?
========================================================

* Recursive queries
* Soporta `XML`, `JSON`, arreglos...
* Extensibilidad:
    - Bibliotecas externas
    - Lenguajes externos
    - Puedes crear tipos de datos, funciones, agregadores, operadores, etc.
* Foreign Data Wrappers (FDW)
* Creación concurrente de índices
* Listen/Notify
* NOSQL dentro de SQL


¿Dónde está PostgreSQL según el CAP?
======================================================
![cap-theorem](images/scalability-cap-theorem1.png)

- Tomado de una página de **IBM**
  - perdí el `URL` :( ...

========================================================
type: exclaim

## PostgreSQL
### Instalación


Instalación
=======================================================

- En distros basadas en `Debian`:

```
> sudo apt-get update
> sudo apt-get -y install python-software-properties
> sudo apt-get install postgresql-9.4 libpq-dev postgresql-contrib
```

- Accesando a la base

```
> sudo su postgres
postgres$ psql
```
- A partir de aquí habrá que crear usuarios

Instalación
=======================================================
- Por omisión, guardará todo en `/`, detenemos y destruimos:

```
> sudo pg_dropcluster --stop 9.4 main
```

- Creamos uno nuevo

```
> sudo pg_createcluster -d ~/data 9.4 main
```

Instalación
=======================================================

- Ahora PostGIS `:)`

```
> sudo apt-get update
> sudo apt-get install postgis
```

- Dentro de `psql` (un poco más adelante)

```
# \dx+
# create extension postgis;
# create extension postgis_topology;
# create extension fuzzystrmatch;
# create extension postgis_tiger_geocoder;
# \dx+
# select postgis_version();
```


========================================================
type: exclaim

## PostgreSQL
## `psql`


psql
=======================================================

- Es el cliente *par excellence* de PostgreSQL.
  - Algunos prefieren `pgadmin`, no lo veremos en el curso...

- Como he dicho en otras ocasiones, las interfaces de línea de comandos (`CLI`) son las más eficientes
  - Y las mejores para **big data**. Punto.

psql
=======================================================

### Modo interactivo

- `\?` les indica que comandos de `psql` existen
  - Algunos comandos útiles: `\l`, `\connect`, `\d`, `\dt`, `\a`,  `\x`, `\i`, `\o`, `\g`, `\!`, `\pset pager`, `\timing on/off`
- `\help` adelante de una sentencia `SQL` les muestra la ayuda de la sentencia
  - **Ejercicio** Intenten `\help select` y ejecútenlo cada vez que veamos un comando de `SQL` que desconozcan.

psql
=======================================================

### Modo interactivo

- Definir un *alias*
  - `\set eav 'EXPLAIN ANALYZE VERBOSE'`

- Otro alias interesante:

```
\set show_slow_queries
'SELECT
  (total_time / 1000 / 60) as total_minutes,
  (total_time/calls) as average_time, query
FROM pg_stat_statements
ORDER BY 1 DESC
LIMIT 100;'
```

psql
=======================================================

### Modo no interactivo

- Para evitar que pregunte la contraseña, creen un archivo `.pgpass` en su `$HOME`
con la siguiente sintaxis:

```
host:port:*:username:password
```

Una línea por cada conexión.


psql
=======================================================

### Modo no interactivo

- Conexión

```
psql -h host -U user -d base_de_datos
```

- Ejecutar un archivo `.sql`

```
psql -f script.sql
```

- Ejecutar un comando `SQL`

```
psql -d base_de_datos -c "SELECT * from pg_tables limit 1;"

## Aquí es un caso donde el infierno de las comillas (quotes) puede aparecer.
```

psql
=======================================================

- **Ejercicio**: Averigua que hace la famosa bandera **axe cutie**: `-Ax -qt` ¿En que circunstancia lo usarías? ¿Y la bandera `-e`?

psql
=======================================================

### Modo interactivo

- Algunas mejoras (ejecuta un `select * from pg_tables` entre cada uno de los siguientes.)






































































































































































































































































```
Error in get_engine(options$engine) : 
  Unknown language engine 'sql' (must be registered via knit_engines$set()).
```
