#!/usr/bin/python

import sys
import jsbeautifier
import os
from bs4 import BeautifulSoup

name = str(sys.argv[1])
res = jsbeautifier.beautify_file(name).encode('utf-8')
rm = 'rm -f '+name
os.system(rm)

soup = BeautifulSoup(res,'html.parser')
ress = (soup.prettify()).encode('utf-8')


f=open(name,'w')
f.write(ress)
f.close()
