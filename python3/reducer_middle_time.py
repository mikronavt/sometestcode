import sys

lastKey = None
lst = []

for line in sys.stdin:
	ln = line.strip().split("\t")
	k = ln[0]
	v = ln[1]
	if lastKey and (lastKey != k):
		mid = sum(lst)//len(lst)
		print(lastKey + '\t' + str(mid))
		lst = []
		lastKey = k
		lst.append(int(v))
	else:
		lastKey = k
		lst.append(int(v))
		
		
if lastKey:
	mid = sum(lst)//len(lst)
	print(lastKey + '\t' + str(mid))