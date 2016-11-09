import sys

old_vert = None
min_dist = 'INF'
full_vertexes = '{}'

for line in sys.stdin:
	l = line.strip().split('\t')
	vert = l[0]
	dist = l[1]
	vertexes = l[2]
	if old_vert and (vert != old_vert):
		print(old_vert + '\t' + min_dist + '\t' + full_vertexes)
		old_vert = vert
		min_dist = 'INF'
		full_vertexes = '{}'
		if dist != 'INF' and (min_dist == 'INF' or (min_dist != 'INF' and int(dist) < int(min_dist))):
			min_dist = dist
		if vertexes != '{}':
			full_vertexes = vertexes
	else:
		old_vert = vert
		if dist != 'INF' and (min_dist == 'INF' or (min_dist != 'INF' and int(dist) < int(min_dist))):
			min_dist = dist
		if vertexes != '{}':
			full_vertexes = vertexes

if old_vert:
	print(old_vert + '\t' + min_dist + '\t' + full_vertexes)