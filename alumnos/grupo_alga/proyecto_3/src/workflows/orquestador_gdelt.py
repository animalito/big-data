import luigi
from luigi.hdfs import HdfsTarget
import os
from io import StringIO
import sys

class LimpiaInformacionTask(luigi.Task):
    
    def output(self):
        return HdfsTarget("/user/itam/datasets/gdelt/resultados/limpieza_info.txt")
    
    def run(self):
        _out = self.output().open("w")
        try: 
            f = os.popen('nohup spark-submit /home/itam/workflows/pyspark_script.py limpieza_datos &')
            res_exec = f.read()
            _out.write("Ejecucion exitosa de LimpiarInformacionTask \n")
            _out.write(str(res_exec) + "\n")
            #print res_exec
        except:
            _out.write("Ejecucion fallida")
        _out.close()

class AnalizaInformacionTask(luigi.Task):

    def requires(self):
        return LimpiaInformacionTask()

    def output(self):
        return HdfsTarget("/user/itam/datasets/gdelt/resultados/analisis_info.txt")

    def run(self):
        #print "\n\n\nInicia ejecucion de analisis de informacion\n\n\n"
        try:
            _in = self.input().open("r")
            _out = self.output().open("w")
            for line in _in:
                _out.write(line) 
                #print line + "\n"
            _in.close()
            _out.close()
        except:
            print "\nERROR  EN ANALISIS DE INFORMACION\n"

class ExportaInformacionTask(luigi.Task):

    def output(self):
        return HdfsTarget("/user/itam/datasets/gdelt/resultados/exportacion_info.txt")

    def requires(self):
        return AnalizaInformacionTask()

    def run(self):
        _in = self.input().open("r")
        _out = self.output().open("w")
        for line in _in:
            _out.write(line)

        _out.close()
        _in.close()


if __name__ == '__main__':
    luigi.run(main_task_cls=ExportaInformacionTask)
