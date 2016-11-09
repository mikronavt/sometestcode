class deque:
	def __init__(self, len):
		self.arr = [0] * len
		self.first = 0
		self.last = 0
		self.len = len
	
	def push_front(self, num):
		if self.first == (self.last + 1)%self.len:
			return -1
		self.first = (self.first - 1)%self.len
		self.arr[self.first] = num
		
	def pop_front(self):
		if self.first == self.last:
			return -1
		else:
			elem = self.arr[self.first]
			self.first = (self.first + 1)%self.len
			return elem
		
	def push_back(self, num):
		if self.last == (self.first - 1)%self.len:
			return -1
		self.last = (self.last + 1)%self.len
		self.arr[(self.last - 1)%self.len] = num
	
	def pop_back(self):
		if self.last == self.first:
			return -1
		else:
			elem = self.arr[(self.last - 1)%self.len]
			self.last = (self.last - 1)%self.len
			return elem


n = int(input())
all_is_ok = True

d = deque(n + 1)


for i in range(n):
	cmd, num = input().split()
	if cmd == '1':
		d.push_front(int(num))
	elif cmd == '2':
		val = d.pop_front()
		if val != int(num):
			all_is_ok = False
			break
	elif cmd == '3':
		d.push_back(int(num))
	elif cmd == '4':
		val = d.pop_back()
		if val != int(num):
			all_is_ok = False
			break

			
print(['NO', 'YES'][all_is_ok])
	
