n = int(input())
a_string = input()
b_string = input()
a = a_string.split()
b = b_string.split()
for i in range(0, n):
	a[i] = int(a[i])
	b[i] = int(b[i])

i_max = 0
j_max = 0
b_max = b[0] 
a_max = a[0]
for i in range(0, n):
	if b[i] > b_max:
		b_max = b[i]
		j_max = i

ab_max = a_max + b_max
for i in range(0, n):
	if a[i] > a_max:
		if j_max >= i:
			i_max = i
			a_max = a[i]
			ab_max = a_max + b_max
		else:
			b_max_new = b[i]
			j_max_new = i
			for j in range(i, n):
				if b[j] > b_max_new:
					b_max_new = b[j]
					j_max_new = j
			
			if a[i] + b_max_new > ab_max:
				a_max = a[i]
				i_max = i
				b_max = b_max_new
				j_max = j_max_new
				ab_max = a_max + b_max

print(i_max, j_max)