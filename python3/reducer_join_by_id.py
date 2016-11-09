import sys

def print_all(id, list1, list2):
	for obj1 in list1:
		for obj2 in list2:
			print(id + "\t" + obj1 + "\t" + obj2)

last_id = None
urls = []
queries = []

for line in sys.stdin:
	l = line.strip().split("\t")
	id = l[0]
	tag = l[1].split(":")[0]
	value = l[1].split(":")[1]
	if last_id and id != last_id:
		print_all(last_id, queries, urls)
		last_id = id
		urls = []
		queries = []
		if tag == "url":
			urls.append(value)
		elif tag == "query":
			queries.append(value)
	else:
		last_id = id
		if tag == "url":
			urls.append(value)
		elif tag == "query":
			queries.append(value)

if last_id:
	print_all(last_id, queries, urls)