#auxiliary heap
class Heap:
	def __init__(self, n):
		self.lst = []
		self.len = 0
		
	def parent_index(self, index):
		if index == 0: return -1
		return (index - 1)//2
	
	def child1_index(self, index):
		ci = 2*index + 1
		if ci >= self.len: return -1
		else: return ci
	
	def child2_index(self, index):
		ci = 2*index + 2
		if ci >= self.len: return -1
		else: return ci
	
	def is_empty(self):
		return self.lst == []
	
	def heap_down(self, i):
		ci1 = self.child1_index(i)
		ci2 = self.child2_index(i)
		this_elem = self.lst[i]
		if ci1 > 0 and ci2 > 0:
			child1 = self.lst[ci1]
			child2 = self.lst[ci2]
			if child1 >= child2 and child1 > this_elem:
				self.lst[i] = child1
				self.lst[ci1] = this_elem
				self.heap_down(ci1)
			elif child2 > child1 and child2 > this_elem:
				self.lst[i] = child2
				self.lst[ci2] = this_elem
				self.heap_down(ci2)
		elif ci1 > 0:
			child1 = self.lst[ci1]
			if child1 > this_elem:
				self.lst[i] = child1
				self.lst[ci1] = this_elem
				self.heap_down(ci1)
	
	def heap_up(self, i):
		if i == 0: return
		pi = self.parent_index(i)
		parent_elem = self.lst[pi]
		this_elem = self.lst[i]
		if this_elem > parent_elem:
			self.lst[i] = parent_elem
			self.lst[pi] = this_elem
			self.heap_up(pi)
	
	def add_new(self, num):
		self.len += 1
		self.lst.append(num)
		self.heap_up(self.len - 1)
		
	def get_max(self):
		if self.is_empty(): return -1
		else: return self.lst[0]
		
	def pop_max(self):
		if self.is_empty(): return -1
		max_elem = self.lst[0]
		self.lst[0] = self.lst[self.len - 1]
		self.len -= 1
		self.lst.pop()
		if self.len > 0:
			self.heap_down(0)
		return max_elem
		
#n - num of elements in array, l - array, 
#k - num of element where for each i,j if j >= i + k, then a[i] <= a[j]
#need to sort array
n = int(input())
l = input().split()
for i in range(n):
	l[i] = int(l[i])
k = int(input())


l = l[::-1]
exit_l = []
h = Heap(k)

for i in range(k):
	h.add_new(l.pop(0))
	


while l:
	exit_l.append(h.pop_max())
	h.add_new(l.pop(0))
	
for i in range(k):
	exit_l.append(h.pop_max())


print(*exit_l[::-1])