import re
f = open('C:\\1\\prog\\testtexts\\regex_sum_203263.txt', 'r')
sum = 0
for line in f:
	nums = re.findall('[0-9]+', line)
	for n in nums:
		number = int(n)
		sum += number

print(sum)