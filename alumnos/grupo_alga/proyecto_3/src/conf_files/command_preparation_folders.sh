## En local (docker): borro todo
rm -R /home/itam/data/datasets/gdelt/flume_spooldir/*

rm -R /opt/gdelt/log/formato_avro/checkpoint/*
rm -R /opt/gdelt/log/formato_avro/data/*


rm -R /opt/gdelt/log/formato_normal/checkpoint/*
rm -R /opt/gdelt/log/formato_normal/data/*

rm -R /opt/gdelt/log/formato_normal_temp/checkpoint/*
rm -R /opt/gdelt/log/formato_normal_temp/data/*

## En local (docker): creo todos los directorios
mkdir -p /home/itam/data/datasets/gdelt/flume_spooldir
mkdir -p /opt/gdelt/log/formato_normal/checkpoint/
mkdir -p /opt/gdelt/log/formato_normal/data
mkdir -p /opt/gdelt/log/formato_normal_temp/checkpoint/
mkdir -p /opt/gdelt/log/formato_normal_temp/data
mkdir -p /opt/gdelt/log/formato_avro/checkpoint/
mkdir -p /opt/gdelt/log/formato_avro/data


## En el hadoop: borro todos los directorios
hadoop fs -rm -R /user/itam/datasets/gdelt/normal
hadoop fs -rm -R /user/itam/datasets/gdelt/avro
hadoop fs -rm -R /user/itam/datasets/gdelt/temp
hadoop fs -rm -R /user/itam/datasets/gdelt/resultados

## En el hadoop: creo todos los directorios
hadoop fs -mkdir -p /user/itam/datasets/gdelt/normal
hadoop fs -mkdir -p /user/itam/datasets/gdelt/avro
hadoop fs -mkdir -p /user/itam/datasets/gdelt/temp
hadoop fs -mkdir -p /user/itam/datasets/gdelt/resultados


## Para ver donde estan, busco la ruta en el docker para los primeros
## hadoop fs -ls directorio para ver que esta todo en el hadoop
