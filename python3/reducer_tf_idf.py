import sys

last_word = None
last_doc = None
sum = 0

for line in sys.stdin:
	word = line.strip().split("\t")[0].split("#")[0]
	doc = line.strip().split("\t")[0].split("#")[1]
	count = int(line.strip().split("\t")[1])
	if (last_word and (last_word != word)) or (last_doc and(last_doc != doc)):
		print(last_word + "\t" + last_doc + "\t" + str(sum))
		last_word = word
		last_doc = doc
		sum = 1
	else:
		last_word = word
		last_doc = doc
		sum += count

if last_word and last_doc:
	print(last_word + "\t" + last_doc + "\t" + str(sum))