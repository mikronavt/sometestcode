import sys

s = set()

for line in sys.stdin:
	l = line.strip().split()
	if l[0] == '+':
		if l[1] in s:
			print('FAIL')
		else:
			s.add(l[1])
			print('OK')
	elif l[0] == '-':
		if l[1] in s:
			s.remove(l[1])
			print('OK')
		else:
			print('FAIL')
	elif l[0] == '?':
		if l[1] in s:
			print('OK')
		else:
			print('FAIL')