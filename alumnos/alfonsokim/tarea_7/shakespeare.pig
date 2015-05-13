shakespeare = load 'books/pg100.txt' using TextLoader as (line:chararray);
illustrate shakespeare;

palabras = foreach shakespeare generate flatten(TOKENIZE(REPLACE(LOWER(TRIM(line)), '[\\p{Punct}, \\p{Cntrl}]', ' '))) as palabra;
illustrate palabras;

grupo = group palabras by palabra;
illustrate grupo;

conteo = foreach grupo generate $0 as palabra, COUNT($1) as cantidad;
illustrate conteo;

ordenados = order conteo by cantidad desc;
illustrate ordenados;

top10 = limit ordenados 10;
dump top10;