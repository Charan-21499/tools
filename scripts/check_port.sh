#!/bin/bash

d=$(date +%Y-%m-%d-%T);
y=$(date -d yesterday +%Y-%m-%d-%T) ;
echo "time:$d";
ip=$1;
if [ -n "$1" ]; then
	if [ -e /root/Desktop/$ip ]; then
		nmap -T4 -oX ~/Desktop/$ip/$d.xml $1; 
	else
		mkdir /root/Desktop/$ip;
		nmap -T4 -oX ~/Desktop/$ip/$d.xml $1  
	fi
else
echo "'format check_port ip_range'"
fi
if [ -e /root/Desktop/$ip/$y.xml ]; then 
	diff /root/Desktop/$ip/$y.xml /root/Desktop/$ip/$d.xml > /root/Desktop/$ip/diff.xml
fi









