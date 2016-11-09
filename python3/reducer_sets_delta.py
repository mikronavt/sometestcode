import sys

last_key = None

for line in sys.stdin:
	k = line.strip().split("\t")[0]
	if last_key and (k != last_key):
		print(last_key)
		last_key = k
	elif k == last_key:
		last_key = None
	else:
		last_key = k

if last_key:
	print(last_key)