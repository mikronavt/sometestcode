import sys

(lastKey, sum, count) = (None, 0, 0)

for line in sys.stdin:
	ln = line.strip().split("\t")
	k = ln[0]
	v1, v2 = ln[1].split(";")
	if lastKey and (k != lastKey):
		print(lastKey + '\t' + str(sum) + ";" + str(count))
		(lastKey, sum, count) = (k, int(v1), int(v2))
	else:
		(lastKey, sum, count) = (k, sum + int(v1), count + int(v2))
		
if lastKey:
	print(lastKey + '\t' + str(sum) + ";" + str(count))