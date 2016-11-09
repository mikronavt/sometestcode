import urllib.request
fhand = urllib.request.urlopen('http://yandex.ru')
for line in fhand:
	print(line.strip())