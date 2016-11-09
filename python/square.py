fig = input();
if fig == "прямоугольник":
	a = int(input());
	b = int(input());
	print(a * b);
elif fig == "треугольник":
	a = int(input());
	b = int(input());
	c = int(input());
	p = (a + b + c) / 2;
	print((p * (p - a) * (p - b) * (p - c)) ** 0.5);
elif fig == "круг":
	r = int(input());
	print(3.14 * r * r);