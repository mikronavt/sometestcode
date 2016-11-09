#fuction sorting line using insertion sort
def insertion_sort(l):
	if len(l) == 1:
		return l
	new_l = []
	middle = len(l)//2
	l_left = insertion_sort(l[0:middle])
	l_right = insertion_sort(l[middle:])
	l_indx = 0
	r_indx = 0
	while l_indx < len(l_left) or r_indx < len(l_right):
		if l_indx >= len(l_left):
			new_l.append(l_right[r_indx])
			r_indx += 1
		elif r_indx >= len(l_right):
			new_l.append(l_left[l_indx])
			l_indx += 1
		else:
			if l_left[l_indx] <= l_right[r_indx]:
				new_l.append(l_left[l_indx])
				l_indx += 1
			else:
				new_l.append(l_right[r_indx])
				r_indx += 1
	return new_l
	

#n - count of lines, then input - coordinates of lines ends
n = int(input())
left = []
right = []
for i in range(n):
	s = input().split()
	left.append(int(s[0]))
	right.append(int(s[1]))

left = insertion_sort(left)
right = insertion_sort(right)

#find count of layers
current_depth = 0
i = 0
j = 0
prev = 0
lines = []
while i < len(left) or j < len(right):
	if i >= len(left):
		lines.append((prev, right[j], current_depth))
		prev = right[j]
		current_depth -= 1
		j += 1
	else:
		if left[i] <= right[j]:
			lines.append((prev, left[i], current_depth))
			prev = left[i]
			current_depth += 1
			i += 1
		else:
			lines.append((prev, right[j], current_depth))
			prev = right[j]
			current_depth -= 1
			j += 1

#find sum length with 1 layer
sum_len = 0
for line in lines:
	if line[2] == 1:
		sum_len += line[1] - line[0]

print(sum_len)
		

