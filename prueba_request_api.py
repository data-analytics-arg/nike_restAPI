import requests
import json

url = 'http://127.0.0.1:5000/NIKE'
r=requests.get(url)
response=r.text
j=response.json()
print(j)
