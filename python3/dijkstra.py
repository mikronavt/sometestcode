v, e = [int(i) for i in input().strip().split()]

graph = {}
for i in range(v):
	graph[i + 1] = []


for i in range(e):
	v1, v2, dist =  [int(i) for i in input().strip().split()]
	graph[v1].append((v2, dist))
	
start, end = [int(i) for i in input().strip().split()]

distances = {}
for i in range(v):
	distances[i + 1] = (False, 'Inf')
	
distances[start] = (False, 0)
current = start

def dj(current):
	for (v2, d) in graph[current]:
		new_d = d + distances[current][1]
		if (distances[v2][1] == 'Inf') or (distances[v2][1] > new_d):
			distances[v2] = (False, new_d)
	distances[current] = (True, distances[current][1])
	nearest_vert = None
	for vert in distances:
		if (not distances[vert][0]) and (distances[vert][1] != 'Inf'):
			if not nearest_vert:
				nearest_vert = vert
			elif distances[nearest_vert][1] > distances[vert][1]:
				nearest_vert = vert
	if nearest_vert:
		dj(nearest_vert)
	
dj(current)
if distances[end][1] == 'Inf':
	print(-1)
else:
	print(str(distances[end][1]))

		
			