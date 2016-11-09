import sys

graph = {}
vertexes = []

for line in sys.stdin:
	l = line.strip().split('\t')
	vert = l[0]
	dist = l[1]
	edges_to = l[2][1:-1].strip().split(',')
	graph[vert] = (dist, edges_to)
	vertexes.append(vert)
	
for v in vertexes:
	edges_to = graph[v][1]
	dist = graph[v][0]
	print(v + '\t' + dist + '\t{' + ','.join(edges_to) + '}')
	if edges_to:
		for vert in edges_to:
			if vert:
				if dist == 'INF':
					d = 'INF'
				else:
					d = str(int(dist) + 1)
				print(vert + '\t' + d + '\t{}')
	