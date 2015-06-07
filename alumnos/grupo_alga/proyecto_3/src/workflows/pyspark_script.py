import os
import csv
from io import StringIO
import sys
from pyspark import SparkContext, SparkConf


def load_tsv(archivo):
    return csv.reader(StringIO(archivo[1]), delimiter="\t")

def limpia_informacion(line): 
    
    return  [line[0], line[1], line[3], line[2].replace(line[3],""),line[1].replace(line[2],"")] + \
        line[5:]

def main_limpia_info(args):
    try:
        conf = (SparkConf().setMaster("local").setAppName("GdeltImportingInfo"))
        sc = SparkContext(conf = conf)  
        obs = sc.textFile("hdfs://localhost/user/itam/datasets/gdelt/temp/*.temp").\
            map(lambda x: x.split("\t") ).map(limpia_informacion)

        obs_mexico = obs.filter(lambda line: line[5] == "MEX" or line[15] == "MEX").map(lambda x: "\t".join(x))
        obs = obs.map(lambda x: "\t".join(x))
        obs_mexico.saveAsTextFile("hdfs://localhost/user/itam/datasets/gdelt/resultados/mexico")
        obs.saveAsTextFile("hdfs://localhost/user/itam/datasets/gdelt/resultados/general")
        #print obs_mexico.take(5)
        print "Ejecucion exitosa de limpieza\n"
    except: 
        print "Ejecucion fallida de limpieza\n"

if __name__ == '__main__':
    #print "Ejecucion de PySpark"
    if sys.argv[1] == "limpieza_datos":
        main_limpia_info(sys.argv)
    #print "Fin de ejecucion"
