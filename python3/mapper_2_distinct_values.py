import sys

for line in sys.stdin:
	group = line.strip().split(",")[1]
	print(group + "\t" + '1')