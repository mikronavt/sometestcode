n = int(input())

l = []
ans = []

for i in range(n):
	str = input().strip().split()
	com = int(str[0])
	val = int(str[1])
	if com == 1:
		l.append(val)
		l.sort()
		l.reverse()
		ans.append(l.index(val))
	else:
		l.pop(val)

print(*ans)