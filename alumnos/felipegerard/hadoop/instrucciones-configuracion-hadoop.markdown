# Este es para ver cómo levantar los servicios. Se borra al final

docker run -ti --name hadoop-pseudo \
  -v /Users/Felipe/big-data/alumnos/felipegerard/hadoop/data:/home/itam/data \
  -p 2122:2122 -p 2181:2181 -p 39534:39534 -p 9000:9000 \
  -p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 \
  -p 50090:50090 -p 8030:8030 -p 8031:8031 -p 8032:8032 \
  -p 8033:8033 -p 8088:8088 -p 8040:8040 -p 8042:8042 \
  -p 13562:13562 -p 47784:47784 -p 10020:10020 -p 19888:19888 \
  -p 8000:8000 -p 9999:9999 \
nanounanue/docker-hadoop

###############################
# Configuración de Hadoop
# En $HADOOP_HOME/hadoop,

### core-site.xml
* Para que corra en modo standalone (ie. sin HDFS), dejamos vacío lo de localhost:9000
* Para que corra en pseudodistribuido, dejamos localhost:9000
* Para que sea distribuido, ponemos una dirección IP

### hdfs-site.xml
* Replicaciones
* Configuración de replicaciones
* Detalles de carpetas a usar en namenode y en datanodes.

### mapred-site.xml


#####################
### Otros
* jps
* java -version


#####################
chown -R hduser:hadoop /home/hduser/hdfs-data/
chown -R hduser:hadoop /srv/hadoop/logs
* Como root:
* service ssh status
* service ssh start
* Como hduser:
* start-dfs.sh

ssh hduser@localhost -p 2122
jps
alias
hls
hls /



##############################
# AHORA SI BIEN
##############################
# EJERCICIOS I y II
##############################

docker run -ti --name hadoop-pseudo \
-v /Users/Felipe/big-data/alumnos/felipegerard/hadoop/data:/home/itam/data \
-p 2122:2122 -p 2181:2181 -p 39534:39534 -p 9000:9000 \
-p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 \
-p 50090:50090 -p 8030:8030 -p 8031:8031 -p 8032:8032 \
-p 8033:8033 -p 8088:8088 -p 8040:8040 -p 8042:8042 \
-p 13562:13562 -p 47784:47784 -p 10020:10020 -p 19888:19888 \
-p 8000:8000 -p 9999:9999 \
nanounanue/docker-hadoop

hadoop fs -cmd 
hadoop fs -ls
hadoop fs -mkdir
hadoop fs -copyFromLocal
hadoop fs -copyToLocal
hadoop fs -put archivo archivo_hdfs
hadoop fs -get archivo_hdfs
hadoop fs -cat archivo_hdfs
hadoop fs -cat archivo_hdfs head
hadoop fs -tail archivo_hdfs
hadoop fs -rm archivo_hdfs


➜  ~  sudo -u hdfs hadoop fs -mkdir /user/itam
➜  ~  sudo -u hdfs hadoop fs -chown itam:itam /user/itam
➜  ~  sudo -u hdfs hadoop fs -ls -R /user
➜  ~  hadoop fs -ls
➜  ~  hadoop fs -mkdir datasets
➜  ~  hadoop fs -mkdir datasets/ufo
➜  ~  hadoop fs -mkdir datasets/gdelt
➜  ~  hadoop fs -put data/UFO* /user/itam/datasets/ufo
➜  ~  hadoop fs -put data/20* /user/itam/datasets/gdelt



...


Spark
>>> import csv
>>> from io import StringIO












$ su itam
$ cd
$ sudo -u hdfs hadoop fs -mkdir /user/itam
➜  ~  sudo -u hdfs hadoop fs -mkdir /user/itam/etl
➜  ~  sudo -u hdfs hadoop fs -mkdir /user/itam/tmp
➜  ~  sudo -u hdfs hadoop fs -mkdir /user/itam/app
➜  ~  sudo -u hdfs hadoop fs -mkdir /user/itam/data
➜  ~  sudo -u hdfs hadoop fs -cd
➜  ~  sudo -u hdfs hadoop fs -ls /user/itam
➜  ~  hadoop fs -mkdir /user/itam/experimentos
➜  ~  sudo -u hdfs hadoop fs -ls /user/itam
➜  ~  hadoop fs -mkdir /user/itam/datasets
➜  ~  hadoop fs -mkdir /user/itam/datasets/ufo
➜  ~  hadoop fs -mkdir /user/itam/datasets/gdelt
$ hadoop fs -copyFromLocal data/UFO-Nov-2014.tsv /user/itam/experimentos/ 
$ hadoop fs -copyFromLocal data/UFO-Dic-2014.tsv /user/itam/experimentos/
$ hadoop fs -cat /user/itam/experimentos/UFO-Dic-2014.tsv | wc -l
$ hadoop fs -cat /user/itam/experimentos/UFO-Dic-2014.tsv | head









