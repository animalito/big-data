
## Para correr el docker
# Levantamos el contenedor
sudo docker run -ti --name hadoop-pseudo \
    -v /home/animalito/Documents/hadoop_data:/home/itam/data \
    -p 2122:2122 -p 2181:2181 -p 39534:39534 -p 9000:9000 \
    -p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 \
    -p 50090:50090 -p 8030:8030 -p 8031:8031 -p 8032:8032 \
    -p 8033:8033 -p 8088:8088 -p 8040:8040 -p 8042:8042 \
    -p 13562:13562 -p 47784:47784 -p 10020:10020 -p 19888:19888 \
    -p 8000:8000 -p 9999:9999 \
    nanounanue/docker-hadoop

# Start: prende el contenedor
# Exec: te conecta al contenedor
sudo docker exec -it hadoop-pseudo /bin/zsh

### En el docker, preparamos para el flume
# Permisos para crear carpetitas, en itam
hadoop fs -chown itam /user/itam/datasets/gdelt
chmod -R 777 /opt
sudo chown -R itam /opt/gdelt

## desde docker, en itam
./command_preparation_folders.sh


### Para correr el flume:
## Paso 1
## Corremos flume desde docker, su itam
flume-ng agent -n GDELTAgent --conf ingestion -f /home/itam/data/conf_files/gdelt_flume_agent.conf
## Paso 2
## Copias el archivo que quieres trepar a la carpeta `flume_spooldir`

### Para ejecutar el luigi
## Paso 1: iniciar el luigi
luigid --port 8000 --background --logdir=/home/itam/workflows/log
## Paso 2:
python orquestador_gdelt.py --scheduler-port 8000
