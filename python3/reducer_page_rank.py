import sys

old_vert = None
sum_rank = 0
old_vertexes = '{}'

for line in sys.stdin:
	l = line.strip().split('\t')
	vert = l[0]
	rank = l[1]
	vertexes = l[2]
	if old_vert and (old_vert != vert):
		print(old_vert + '\t' + '{:.3f}'.format(sum_rank) + '\t' + old_vertexes)
		sum_rank = 0
		old_vertexes = '{}'
	old_vert = vert
	if vertexes != '{}':
		old_vertexes = vertexes
	else:
		sum_rank += float(rank)

if old_vert:
	print(old_vert + '\t' + '{:.3f}'.format(sum_rank) + '\t' + old_vertexes)