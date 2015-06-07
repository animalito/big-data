CREATE TABLE actiontypes AS
select gdeltetled.actiongeo_type, count (DISTINCT gdeltetled.globaleventid) from gdeltetled group by gdeltetled.actiongeo_type;

-- Pa ver que tablas tienes
-- SHOW TABLES;
-- Pa ver las columnas de tabla
-- DESCRIBE tablename;


