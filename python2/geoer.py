import urllib
import json

serviceurl = 'http://maps.googleapis.com/maps/api/geocode/json?'

address = raw_input('Enter location: ')
url = serviceurl + urllib.urlencode({'sensor':'false', 'address':address})
print 'Knocking to url: ' + url

uu = urllib.urlopen(url)
data = uu.read()

j = json.loads(data)
print json.dumps(j, indent=4)

j1 = j["results"][0]["place_id"]
print json.dumps(j1, indent=4)
