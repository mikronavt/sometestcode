import sys

for line in sys.stdin:
	lst = line.strip().split(" ")
	dict = {}
	for obj1 in lst:
		dict[obj1] = dict.get(obj1, {})
		for obj2 in lst:
			if obj1 != obj2:
				dict[obj1][obj2] = dict[obj1].get(obj2, 0) + 1
	for key1 in dict:
		if dict[key1] != {}:
			s = key1 + '\t'
			for key2 in dict[key1]:
				s = s + key2 + ':' + str(dict[key1][key2]) + ','
			s = s[0:-1]
			print(s)