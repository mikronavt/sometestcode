import sys, re

for line in sys.stdin:
	lst = line.strip().split(":", maxsplit = 1)
	doc_id = lst[0]
	string = lst[1]
	pat = re.compile('\W+')
	words = pat.split(string)
	for w in words:
		if w:
			print(w + "#" + doc_id + "\t" + '1')