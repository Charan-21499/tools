#!/usr/bin/python
#usage js_beautifier.py file
import sys
import jsbeautifier
import os
from bs4 import BeautifulSoup

#used to take file name from command line
name = str(sys.argv[1])

#js beautifying
res = jsbeautifier.beautify_file(name).encode('utf-8')

#removing exsisting file
rm = 'rm -f '+name
os.system(rm)

# html beautifying
soup = BeautifulSoup(res,'html.parser')
ress = (soup.prettify()).encode('utf-8')

#creating a file with a predefined name and writting to it 
f=open(name,'w')
f.write(ress)
f.close()
