import random
str = input()
arr = str.split()
for i in range(len(arr)):
	arr[i] = int(arr[i])



for i in range(len(arr)):
	for j in reversed(range(1, i + 1)):
		if(arr[j - 1] > arr[j]):
			tmp = arr[j]
			arr[j] = arr[j - 1]
			arr[j - 1] = tmp
		#else:
		#	break;

print(*arr)


#for i in range(0, 5):
#	arr = 100*list(range(500))
#	random.shuffle(arr)

arr.sort()
		
#	tmp = arr[0]
#	for el in arr:
#		if el < tmp:
#			print("BAD TEST")
#			print(*arr)
#		tmp = el

