-- No todas transaccionan al mismo tiempo. 
-- Seleccionamos todas las fechas con distribucion normal mu-5 y sd. 2
-- Las tarjetas las pasamos a un array que seleccionamos aleatoriamente
select d.fecha, (SELECT ARRAY(select mis_extensiones.uuid_generate_v4() as tarjeta from generate_series(1,15)))[trunc(random()*15)+1]  as tarjeta	
from (select now()::timestamp - '100 days 10 minutes 1 second'::interval * trunc(mis_extensiones.normal_rand(100,5,2)) fecha) d;

-- Ahora insertamos el query 
select d.fecha, 
	(SELECT ARRAY(select mis_extensiones.uuid_generate_v4() as tarjeta from generate_series(1,15)))[trunc(random()*15)+1]  as tarjeta, 
	(ARRAY['ATM', 'COMERCIO', 'INTERNET'])[trunc(random()*3)+1] as tipo_comercio, 
	(random() * 10000 + 1)::int AS monto , 
	(ARRAY['COLONIA 1', 'COLONIA 2', 'COLONIA 3', 'COLONIA 4', 'COLONIA 5', 'COLONIA 6', 'COLONIA 7', 'COLONIA 8', 'COLONIA 9', 'COLONIA 10'])[trunc(random()*10)+1]::varchar(10) AS Colonia
into transacciones
from (select now()::timestamp - '100 days 1 hour 10 minutes 1 second'::interval * trunc(mis_extensiones.normal_rand(100,5,1)) fecha) d;


--    Escribe una función en python que cree una tabla mejorada de transacciones.
--    Usa 20 tarjetas, con un uso distribuido normalmente, gasto distribuido normalmente, etc, etc.

CREATE TYPE transaccion AS (
  fecha   text,
  tarjeta  uuid,
  monto	integer,
  tipo_comercio text,
  colonia text
);


CREATE OR REPLACE FUNCTION CreateTransa() RETURNS SETOF transaccion AS $$
	import random
	import uuid
	import numpy as np
	import datetime

	mont=[abs(int(random.gauss(6,2)))%12 for i in range(100)]
	day=[abs(int(random.gauss(15,10)))%28 for i in range(100)]
	hour=[abs(int(random.gauss(12,10))) for i in range(100)]
	minute=[abs(int(random.gauss(30,20))) for i in range(100)]
	dates_list = [datetime.datetime(2014,1 if mont[i]==0 else mont[i],1 if day[i]==0 else day[i],hour[i]%24,minute[i]%60) for i in range(len(day))]
	gasto = abs(np.random.normal(10000,5000,100))
	tarjetas = [str(uuid.uuid4()) for i in range(20)]
	tipo_comercio = ['ATM', 'COMERCIO', 'INTERNET']
	colonia = ['COLONIA '+ str(idx) for idx in range(10)]
	trans=[]
	for i in range(100):
	  yield {
	  "fecha":dates_list[i],
	  "tarjeta":tarjetas[i%20],
	  "monto":int(gasto[i]),
	  "tipo_comercio":tipo_comercio[int(random.gauss(3,1))%3],
	  "colonia":colonia[int(random.gauss(5,2))%10]
	  }
$$ LANGUAGE plpythonu;

SELECT * 
INTO MAS_TRANSA 
FROM CreateTransa();
