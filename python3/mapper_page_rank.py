import sys


graph = {}
vertexes = []

for line in sys.stdin:
	l = line.strip().split('\t')
	vert = l[0]
	page_rank = l[1]
	edges_to =  l[2][1:-1].strip().split(',')
	if '' in edges_to:
		edges_to.remove('')
	graph[vert] = (page_rank, edges_to)
	vertexes.append(vert)
	print(line.strip())
	for target_edge in edges_to:
		target_rank = float(page_rank)/len(edges_to)
		print(target_edge + '\t' + '{:.3f}'.format(target_rank) + '\t{}')

	
