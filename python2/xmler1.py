import urllib
import xml.etree.ElementTree as ET

url = raw_input('Enter url for XML: ')

url_connection = urllib.urlopen(url)

data_xml = url_connection.read()

tree = ET.fromstring(data_xml)

counts = tree.findall('.//count')


sum = 0
for c in counts:
	sum += int(c.text)

print sum