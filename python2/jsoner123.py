import urllib
import json

url_link = raw_input('Enter url: ')
url = urllib.urlopen(url_link)
data = url.read()

info = json.loads(data)

sum = 0
for l in info["comments"]:
	sum += int(l["count"])

print sum