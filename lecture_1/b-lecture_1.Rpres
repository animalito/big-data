Big data :: Lecture 1
========================================================
author: Adolfo De Unánue T.
date: 14 de Enero, 2015
font-import: http://fonts.googleapis.com/css?family=Risque
font-family: 'Risque'

Generalidaddes
=======================================================
type: sub-section

¿Quién?
========================================================
![hola](images/hello.svg)

¿Quién?
========================================================
- CTO @ OPI - Open Intelligence
- Trabajo anterior: Data Scientist @ Sm4rt Predictive Systems
- Doctorado, MC^2

Outline del curso
============================================================
- Motivación
- Patrón básico: *Split-Apply-Combine*
- Quick & dirty: *Unix tools*
- ¿Cómo le hago en *R*?
- Oldies pero goodies: *RDBMS*
- Arquitecturas Lambda
- Aplicaciones de datos
- Ecosistema Hadoop
- MapReduce - HDFS
- Hadoop 2: YARN
- Hive, Pig
- Spark
- Arquitecturas Hadoop

Requisitos y Recomendaciones
===================================================================
- Estadística
- No mucha, no ser un *fanático*
- Programación
- `R`, `Python`
- Curiosidad
- No tener aversión a la consola
- Su vida será más feliz si usan `GNU/Linux`
- De preferencia algún *box* basado en `Debian`
- Y más feliz si usan `GNU/Emacs`
- Mucha paciencia


Poyectos y calificación
=====================================================
- Tareas divertidas
- Proyecto final
- Un avance a la mitad

Motivación
===============================================================
type: sub-section

¿Qué es Big data?
========================================================
- Es un concepto relativo (como todo aquello que está relacionado con el tamaño)
- Cuando la información no viene en formatos estructurados
- Crecimiento acelerado en la adquisición de datos, hardware, alamacenamiento,
paralelismo, tiempo de proceso, etc.
- Análisis de datos de varias fuentes distintas

Motivación - Ejemplos
========================================================
*Web logs, RFID, sensor networks, social networks, social data, páginas de
Internet, Indexado y búsqueda de páginas de internet, detalle de llamadas,
datos astronómicos, ciencia, datos genómicos, biogeoqu ́ımicos, biol ́ogicos,
vigilancia (cámas de vídeo, por ejemplo), biogeoquímicos, biológicos, registros médicos,
fotografías, vídeo, transacciones bancarias* etc.

Meanwhile, back to 2012
========================================================
- 30 x 10^9 contenidos se agregaron a Facebook en octubre de 2012por 600 millones de usuarios
- 32 x 10^9 de búsquedas se hicieron ese mismo mes en Twitter y se publicaron en promedio
50 x 10^6 de *tuits* al día.
- Cada segundo se enviaron 2.9 x 10^6 millones de correos.
- ... se ven 2 x 10^9 millones de videos en YouTube y se subieron 20 horas de vídeo por minuto.
- 4,672 mensajes envía en adolescente promedio^*

¿Y ahora?
========================================================
- Se calculó que para 2015 el tráfico se cuadriplicará.
- 3x10^9 personas conectadas contribuyendo a una información acumulada de 8 zetabytes.
- Walmart procesa actualmente 10^6 transacciones cada hora.
- Internet de las cosas

Dimensiones
========================================================
- **Volumen**
- *Fermi problem* ¿Cuántas tarjetas bancarias transaccionan en México? ¿Al día?
- **Variedad**
- Estructurado, sin estructurar, mezclado
- **Velocidad**
- Bolsa de valores, transacciones, *reality mining* ¿Es caótico?¿Markoviano?¿Cuál es su dinámica?
- **Veracidad**
- ¿Cómo garantizar que al pegar las fuentes sigue teniendo sentido?

Retos
=============================================================
- Procesamiento, análisis, obtención (*retrival*), *caching*, arquitectura y análisis de datos.
- Sistemas en infraestructura.
- Permisos, integridad de datos, seguridad, privacidad, cifrado.

¿Es necesaria?
==============================================================
- Problemas de *bias*: no se ejecuta un muestreo (*sampling*)
- ¿Es el fin de la teoría?
- ¿O es una validación del método científico?
- *Quis custodiet ipsos custodes?*

¿Para que se requiere?
==============================================================
- En realidad es *Data mining* ...
- Analítica
- Incluyendo a la hermana tonta: *BI* (que ahora es *visualización*)
- Aprendizaje de máquina
- *NoSQL*
- *No relacionales*, en realidad, pero ya saben *hype*...

¿Es un hype?
========================================================
type: alert
- Respuesta corta: **Sí**
- Es una tecnología, se confunde con una técnica o algoritmos
- ¿Es un espejismo?: **No**
- El problema existe y hay que resolverlo

Diferentes tipos
=========================================================
- *Datawarehousing*
- *Data process pipeline*
Intentaremos ver ambos en el curso

Q & A
======================================================
- ¿Así serán todas las clases?
- Claro que no, es un curso *hands on*
- ¿Mi máquina podrá?
- Imagino que no...
- ¿Puedo usar Windows?
- No va a aguantar y más bien ... *¿Qué haces usando windows?*
