import sys

last_A_key = None

for line in sys.stdin:
	lst = line.strip().split("\t")
	k = lst[0]
	union = lst[1]
	if last_A_key and (k != last_A_key):
		print(last_A_key)
		if union == "A":
			last_A_key = k
		else:
			last_A_key = None
	elif union == "A":
		last_A_key = k
	else:
		last_A_key = None

if last_A_key:
	print(last_A_key)