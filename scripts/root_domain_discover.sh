list(){
touch $1_rootdomain.txt

#crt.sh
curl -s https://crt.sh/?Identity=%.$1 | grep ">*.$1" | sed 's/<[/]*[TB][DR]>/\n/g' \
	|grep -vE "<|^[\*]*[\.]*$1" \
	| sort -u | awk 'NF' \
	| tee -a  $1_rootdomain.txt 
	

#certspotter
curl -s https://certspotter.com/api/v0/certs\?domain\=$1 \
	| jq '.[].dns_names[]' | sed 's/\"//g' \
	| sed 's/\*\.//g' | sort -u | grep $1 \
	| tee -a $1_rootdomain.txt
	
#threatcrowd
curl -s https://www.threatcrowd.org/searchApi/v2/domain/report//?domain=%$1 \
	|jq .subdomains | grep $1 \
	| sed s/\"//g | sed s/\,//g | sed 's/ //g' \
	|  tee -a $1_rootdomain.txt
		
#assetfinder
assetfinder --subs-only $1 | tee -a $1_rootdomain.txt


touch temp 
cat $1_rootdomain.txt > temp 
cat temp | sort -u > $1_rootdomain.txt
rm temp 

echo "[+] total rootdomain collected on $1 is $(cat $1_rootdomain.txt | wc -l )"

}
list $1 
