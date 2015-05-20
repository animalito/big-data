Proyecto 2. UFO + GDELT
=================================

Proceso de ETL de UFO (incluye bajada de la información) y GDELT (_no_ incluye bajada de la información) en sus respectivas carpetas. Ahí también se encuetran los códigos básicos (sucios) con los que hicimos el análisis. En la carpeta `entregable` está el .Rmd y el reporte final con los análisis en HTML. No incluí todo el ETL explícitamente porque es demasiado largo. Solamente lo describí en el reporte.

Descripción de las carpetas:

* `data`: Contiene los datos crudos de UFO y GDELT y los procesados de UFO.
* `entregable`: RMarkdown y __reporte en HTML__.
* `gdelt` y `ufo`: contienen el códgo para procesar y hacer los queries a cada base.
    + Ojo: Después de la versión 2 del código cambió la estructura de carpetas, así que hay que tener cuidado al ejecutar algo de nuevo, en especial los .sql con rutas absolutas.
* `old_code_v*`: contienen las versiones anteriores del código.
* `output`: Bases de salida de PostgreSQL, tanto de UFO (sólo un par) como de GDELT.
