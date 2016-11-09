import sys

for line in sys.stdin:
	lst = line.strip().split("\t")
	print(lst[0] + "\t" + lst[1] + ";" + lst[2] + ";1")