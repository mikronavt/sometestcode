import sys

for line in sys.stdin:
	lst = line.strip().split(" ")
	for obj1 in lst:
		for obj2 in lst:
			if obj1 != obj2:
				print(obj1 + "," + obj2 + "\t" + '1')