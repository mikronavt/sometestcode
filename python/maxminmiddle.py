a = int(input());
b = int(input());
c = int(input());
if a > c and a > b:
	max = a;
	if c > b:
		middle = c;
		min = b;
	else:
		middle = b;
		min = c;
elif b > c and b > a:
	max = b;
	if a > c:
		middle = a;
		min = c;
	else:
		middle = c;
		min = a;
else:
	max = c;
	if a > b:
		middle = a;
		min = b;
	else:
		middle = b;
		min = a;

print(max);
print(min);
print(middle);