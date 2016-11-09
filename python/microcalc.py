x = double(input());
y = double(input());
op = input();
if op == '+':
	print(x + y);
elif op == '-':
	print(x - y);
elif (op == '/' and y == 0):
	print("Деление на 0!");
elif op == '/':
	print(x / y);
elif op == '*':
	print(x * y);
elif (op == 'mod' and y == 0):
	print("Деление на 0!");
elif op == 'mod':
	print(x % y);
elif op == 'pow':
	print(x ** y);
elif (op == 'div' and y == 0):
	print("Деление на 0!");
elif op == 'div':
	print(x // y);