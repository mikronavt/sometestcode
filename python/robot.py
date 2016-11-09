n = int(input());
m = n % 100;
if m == 11 or m == 12 or m == 13 or m == 14:
	print(n, "программистов");
elif m%10 == 1:
	print(n, "программист");
elif m%10 == 2 or m%10 == 3 or m%10 == 4:
	print(n, "программиста");
else:
	print(n, "программистов");