number = input()
n = int(number)
nums = list()
i = 2
while i <= n:
	if n%i == 0:
		nums.append(i)
		n = n/i
	else:
		i += 1

print(*nums)

