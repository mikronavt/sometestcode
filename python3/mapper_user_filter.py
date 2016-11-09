import sys

for line in sys.stdin:
	lst = line.strip().split("\t")
	if lst[1] == 'user10':
		print(lst[0] + "\t" + lst[1] + "\t" + lst[2])