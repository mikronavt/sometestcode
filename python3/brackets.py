class Stack:
	def __init__(self):
		self.items = []
	
	def isEmpty(self):
		return self.items == []
	
	def push(self, item):
		self.items.append(item)
	
	def pop(self):
		return self.items.pop()


brackets = input()
s = Stack()
flag = True

for c in brackets:
	if c == '(' or c == '[' or c == '{':
		s.push(c)
	elif c == ')' or c == ']' or c == '}':
		if s.isEmpty(): 
			s.push(c)
		else:
			c0 = s.pop()
			if c0 in [')', '}', ']']:
				s.push(c0)
				s.push(c)
			elif (c0 in ['[','{'] and c == ')') or (c0 in ['(', '{'] and c ==']') or (c0 in ['(', '['] and c == '}') :
				flag = False
				break

if flag:
	left_brackets = []
	right_brackets = []
	while not s.isEmpty():
		c = s.pop()
		if c == '{':
			right_brackets.append('}')
		elif c == '[':
			right_brackets.append(']')
		elif c == '(':
			right_brackets.append(')')
		elif c == '}':
			left_brackets.append('{')
		elif c == ']':
			left_brackets.append('[')
		elif c == ')':
			left_brackets.append('(')
	new_brackets = ''.join(left_brackets) + brackets + ''.join(right_brackets)
	print(new_brackets)
	
else:
	print('IMPOSSIBLE')
			

