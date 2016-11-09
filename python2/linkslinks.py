import urllib
from BeautifulSoup import *
url = raw_input('Enter url: ')
position = raw_input('Enter position: ')
pos = int(position)
repeat = raw_input('Enter how many times repeat this: ')
rep = int(repeat)

for i in range(rep):
	html = urllib.urlopen(url).read()
	soup = BeautifulSoup(html)
	tags = soup('a')


	url = tags[pos - 1].get('href', None)
	name = tags[pos - 1].contents[0]
	print name