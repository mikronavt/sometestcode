import sys



(last_word, last_docs, last_tfs, sum) = (None, [], [], 0)


for line in sys.stdin:
	word, numbers = line.strip().split("\t")
	doc, tf, count = numbers.split(";")
	if last_word and (word != last_word):
		for i in range(len(last_docs)):
			print(last_word + "#" + last_docs[i] + "\t" + last_tfs[i] + "\t" + str(sum))
		(last_word, last_docs, last_tfs, sum) = (word, [], [], 1)
		last_docs.append(doc)
		last_tfs.append(tf)
	else:
		last_word = word
		last_docs.append(doc)
		last_tfs.append(tf)
		sum += int(count)

if last_word:
	for i in range(len(last_docs)):
		print(last_word + "#" + last_docs[i] + "\t" + last_tfs[i] + "\t" + str(sum))