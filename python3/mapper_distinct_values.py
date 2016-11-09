import sys

for line in sys.stdin:
	ln = line.strip().split('\t')
	num = ln[0]
	groups = ln[1].split(',')
	for g in groups:
		print(num + ',' + g + '\t' + '1')