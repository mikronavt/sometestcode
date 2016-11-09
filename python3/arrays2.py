n = int(input())
a_string = input()
a = a_string.split()
for i in range(0, n):
	a[i] = int(a[i])
m = int(input())
b_string = input()
b = b_string.split()
for i in range(0, m):
	b[i] = int(b[i])

#import random
#n = 100
#m = 30
#a = list()
#b = list()
#for i in range(n):
#	a.append(10*i)

#for i in range(m):
#	b.append(random.randint(0, 1000))

def difference(num1, num2):
	return abs(num1 - num2)
	
def min_diff_up(a, left, right, num):
	if left == right:
		return left
	elif left == right - 1:
		if difference(a[left], num) <= difference(a[right], num):
			return left
		else:
			return right
	else:
		middle0 = (left + right)//2
		middle1 = middle0 + 1
		a_mid0 = a[middle0]
		a_mid1 = a[middle1]
		if a_mid0 <= num and a_mid1 >= num:
			if difference(a_mid0, num) <= difference(a_mid1, num):
				return middle0
			else:
				return middle1
		elif a_mid0 > num:
			return min_diff_up(a, left, middle0, num)
		else:
			return min_diff_up(a, middle1, right, num)


			

l = list()
for i in range(0, m):
	l.append(min_diff_up(a, 0, n-1, b[i]))

#print(*a)
#print('--------')
#print(*b)
#print('--------')
print(*l)
