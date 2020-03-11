#!/bin/python3
import sys
from datetime import datetime as dt
import socket

if len(sys.argv)==2:
    target = socket.gethostbyname(sys.argv[1])
else:
    print("invalid INPUT\nsyntax:\n[-]python3 port_scanner.py <HOST_NAME.>")
    sys.exit()

a = int(input("[+] starting port number:"))
b = int(input("[+] ending port number:"))
print('-'*100)
print("scanning target "+target)
print("time started "+ str(dt.now())) 
print('-'*100)  

try:
    list_of_ports = []
    for port in range(a,b):
        s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        socket.setdefaulttimeout(1)
        result = s.connect_ex((target,port)) #error indicator returns 0 if it connects 
        print("checking port {}".format(port))
        if result == 0:
            list_of_ports.append(port)
        s.close()
    print("list of free port "+str(list_of_ports))


except KeyboardInterrupt:
    print("keyboard interruption \n exiting ....")
    sys.close()

except socket.gaierror:
    print("Host name not been resolved")
    sys.close()

except socket.error:
    print("could not connect to server")
    sys.close()