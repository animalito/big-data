import pandas as pd
import sys
import re
import numpy as np
es_num =r'([0-9]+)'
es_letra = r'"([A-Z]+)"'
def toletter(x):
	match = re.match(es_letra,x)
	aux = ''
	if match:
		aux = str(match.group(1))
	return aux
def toYear(x):
	match= re.match(es_num,x)
	if match:
		aux = int(match.group(1))
		if aux < 15:
			return 2000+aux
		else:
			return 1900+aux
def main():
	line = sys.stdin.readline()
	id = 0
	df = pd.DataFrame(columns= ["date","state","year"])
	while line:
		date,state = line.split(',')
		day,month,year = date.split("/")
		year = toYear(year)
		state = toletter(state)
		df.loc[id]=[date,state,year]
		line = sys.stdin.readline()
		id += 1

	df =df.dropna()
	dfFL_count =pd.DataFrame({'count' : df.groupby( [ 'state', 'year'] ).size()}).reset_index()
	xtics = np.arange(1900,2020,20)
	plot = dfFL_count.pivot_table("count", rows="year").plot(xticks=xtics)
	fig = plot.get_figure()
	fig.savefig("/home/itam/proyectos/alumnos/aaronsapa1/proyecto1/todos.png")

	FLindex=dfFL_count.index[dfFL_count.state=='CA']
	MAindex=dfFL_count.index[dfFL_count.state=='FL']
	TXindex=dfFL_count.index[dfFL_count.state=='WA']
	CAindex=dfFL_count.index[dfFL_count.state=='NY']
	segmentos = []
	segmentos.append(dfFL_count.ix[FLindex])
	segmentos.append(dfFL_count.ix[MAindex])
	segmentos.append(dfFL_count.ix[TXindex])
	segmentos.append(dfFL_count.ix[CAindex])
	states=pd.concat(segmentos, ignore_index=True)
	pivotTable=states.pivot_table('count',rows='year', cols='state')
	plot = pivotTable.plot(xticks=xtics)
	fig = plot.get_figure()
	fig.savefig("/home/itam/proyectos/alumnos/aaronsapa1/proyecto1/output.png")


	print(sys.argv[1])
	df =df[df.state==sys.argv[1]]
	dfFL_count =pd.DataFrame({'count' : df.groupby( [ 'state', 'year'] ).size()}).reset_index()
	pivotTable2=dfFL_count.pivot_table('count',rows='year', cols='state')
	plot =pivotTable2.plot(xticks=xtics)
	fig = plot.get_figure()
	fig.savefig("/home/itam/proyectos/alumnos/aaronsapa1/proyecto1/res.png")




if __name__ == '__main__':
	main()