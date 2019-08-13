import requests
import time
import sys

url = "http://192.168.143.117/LED={code}"
code = "... --- ... "

def on_for(t):
    requests.get(url.format(code='ON'))
    time.sleep(t)
    requests.get(url.format(code='OFF'))

while True:
    for c in code:
        print (c, end='')
        sys.stdout.flush()
        if c == ".":
            on_for(0.1)
        elif c == "-":
            on_for(0.3)
        time.sleep(0.1)
    time.sleep(0.9)
