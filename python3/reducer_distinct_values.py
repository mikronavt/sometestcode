import sys

last_pair = None

for line in sys.stdin:
	pair = line.strip().split("\t")[0]
	if last_pair and (pair != last_pair):
		print(last_pair)
		last_pair = pair
	else:
		last_pair = pair

if last_pair:
	print(last_pair)