import sys

for line in sys.stdin:
	dict = {}
	for word in line.split():
		if word:
			dict[word] = dict.get(word, 0) + 1
	for w in dict:
		v = str(dict.get(w))
		print(w + '\t' + v)