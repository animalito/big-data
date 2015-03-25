-- Query para generar transacciones
-- con colonias 10 aleatorias,
-- hora y saltos de mas de un dia

select
    generate_series as fecha,
    cus.tarjeta as tarjeta,
    (ARRAY['ATM', 'COMERCIO', 'INTERNET'])[trunc(random()*3)+1] as tipo_comercio,
    'colonia ' || ((random() * 10)::integer)::char as colonia,
    (random() * 10000 + 1)::int AS monto
    -- Descomentar para generar la tabla
    -- into transacciones 
from generate_series((now() - '100 days'::interval)::timestamp,     -- 100 dias 
                     now()::date,                                   -- Fecha de inicio
                     -- Salto de la serie; los valores aleatorios son para agregar horas a la
                     -- fecha y que las transacciones no sean cada dia
                     ((((random() * 10) + 1)::integer)::char || ' day')::interval + 
                       ((random() + 1) * '12:00:00'::time)),
(select uuid_generate_v4() as tarjeta from generate_series(1,15)) cus;

