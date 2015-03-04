#Remueve el header que se concatena en la combinacion de archivos.
# Lo raro del mundo es si lleva Date --> Toma el caracter anterior por eso esta ate.

cat UFO-Nov-Dic-2014.tsv | grep '[^^]ate \/ Time.*$' 
