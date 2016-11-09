import sys

s = set()
dict = {}

for line in sys.stdin:
	(v, k) = line.strip().split('\t')
	s.add((v, k))

for el in s:
	dict[el[1]] = dict.get(el[1], 0) + 1

for key in dict:
	print(key + "\t" + str(dict.get(key)))