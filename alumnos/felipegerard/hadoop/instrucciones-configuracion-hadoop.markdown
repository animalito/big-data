# Este es para ver cómo levantar los servicios. Se borra al final

docker run -ti --rm \
  -e "AUTHORIZED_SSH_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)" \
  -v /Users/Felipe/big-data/alumnos/felipegerard/hadoop/tmp/docker-hadoop-data/:/home/hduser/hdfs-data/ \
  -v /Users/Felipe/big-data/alumnos/felipegerard/hadoop/tmp/docker-hadoop-logs/:/srv/hadoop/logs/ \
  -p 2122:2122 -p 2181:2181 -p 39534:39534 -p 9000:9000 \
  -p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 \
  -p 50090:50090 -p 8030:8030 -p 8031:8031 -p 8032:8032 \
  -p 8033:8033 -p 8088:8088 -p 8040:8040 -p 8042:8042 \
  -p 13562:13562 -p 47784:47784 -p 10020:10020 -p 19888:19888 \
nanounanue/docker-hadoop /bin/bash

docker run -ti --rm \
  -e "AUTHORIZED_SSH_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)" \
  -v /Users/Felipe/tmp/docker-hadoop-data/:/home/hduser/hdfs-data/ \
  -v /Users/Felipe/tmp/docker-hadoop-logs/:/srv/hadoop/logs/ \
  -p 2122:2122 -p 2181:2181 -p 39534:39534 -p 9000:9000 \
  -p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 \
  -p 50090:50090 -p 8030:8030 -p 8031:8031 -p 8032:8032 \
  -p 8033:8033 -p 8088:8088 -p 8040:8040 -p 8042:8042 \
  -p 13562:13562 -p 47784:47784 -p 10020:10020 -p 19888:19888 \
nanounanue/docker-hadoop /bin/bash



# Este no tiene comando al final (/bin/bash, por ejemplo)
# Este levanta todo automáticamente
# Password: hduser. No debería pedirlo si está bien configurado el .ssh

docker run -ti --name hadoop_pseudodistribuido \
  -e "AUTHORIZED_SSH_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)" \
  -v /Users/Felipe/big-data/alumnos/felipegerard/hadoop/tmp/docker-hadoop-data/:/home/hduser/hdfs-data/ \
  -v /Users/Felipe/big-data/alumnos/felipegerard/hadoop/tmp/docker-hadoop-logs/:/srv/hadoop/logs/ \
  -p 2122:2122 -p 2181:2181 -p 39534:39534 -p 9000:9000 \
  -p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 \
  -p 50090:50090 -p 8030:8030 -p 8031:8031 -p 8032:8032 \
  -p 8033:8033 -p 8088:8088 -p 8040:8040 -p 8042:8042 \
  -p 13562:13562 -p 47784:47784 -p 10020:10020 -p 19888:19888 \
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














