import sys

dict = {}
while 1:
	line = sys.stdin.readline()
	for word in line.split():
		if word:
			dict[word] = dict.get(word, 0) + 1
	if not line.strip():
		break
for w in dict:
	v = str(dict.get(w))
	print(w + '\t' + v)